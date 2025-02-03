import SwiftUI
import MapboxSearch
import MapboxMaps

class SearchViewModel: ObservableObject {
    @Published var suggestions: [SearchSuggestion] = []
    private let searchEngine: SearchEngine
    private var completionHandler: ((CLLocationCoordinate2D?) -> Void)?
    
    init(accessToken: String) {
        self.searchEngine = SearchEngine(accessToken: accessToken)
        self.searchEngine.delegate = self
    }
    
    func performSearch(query: String) {
        guard !query.isEmpty else {
            suggestions = []
            return
        }
        
        let options = SearchOptions(languages: ["en"])
        searchEngine.search(query: query, options: options)
    }
    
    func selectSuggestion(_ suggestion: SearchSuggestion, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        self.completionHandler = completion
        searchEngine.select(suggestion: suggestion)
    }
}

extension SearchViewModel: SearchEngineDelegate {
    func suggestionsUpdated(suggestions: [SearchSuggestion], searchEngine: SearchEngine) {
        DispatchQueue.main.async {
            self.suggestions = suggestions
        }
    }
    
    func resultResolved(result: SearchResult, searchEngine: SearchEngine) {
        DispatchQueue.main.async {
            self.completionHandler?(result.coordinate)
            self.completionHandler = nil
        }
    }
    
    func searchErrorHappened(searchError: SearchError, searchEngine: SearchEngine) {
        print("Search error: \(searchError)")
        DispatchQueue.main.async {
            self.completionHandler?(nil)
            self.completionHandler = nil
        }
    }
}

struct MapSearchView: View {
    @Binding var selectedCoordinate: CLLocationCoordinate2D?
    @StateObject private var viewModel: SearchViewModel
    @State private var searchText = ""
    @Environment(\.dismiss) private var dismiss
    
    init(selectedCoordinate: Binding<CLLocationCoordinate2D?>) {
        self._selectedCoordinate = selectedCoordinate
        let accessToken = Bundle.main.object(forInfoDictionaryKey: "MBXAccessToken") as! String
        self._viewModel = StateObject(wrappedValue: SearchViewModel(accessToken: accessToken))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Search input at the top
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundStyle(.secondary)
                    
                    TextField("Search location...", text: $searchText)
                        .textFieldStyle(.plain)
                        .autocorrectionDisabled()
                    
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                
                Divider()
                
                // Suggestions list
                if !viewModel.suggestions.isEmpty {
                    List(viewModel.suggestions, id: \.id) { suggestion in
                        Button(action: {
                            viewModel.selectSuggestion(suggestion) { coordinate in
                                if let coordinate {
                                    selectedCoordinate = coordinate
                                    dismiss()
                                }
                            }
                        }) {
                            VStack(alignment: .leading) {
                                Text(suggestion.name)
                                    .font(.system(size: 16, weight: .medium))
                                if let address = suggestion.address?.formattedAddress(style: .medium) {
                                    Text(address)
                                        .font(.system(size: 14))
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .onChange(of: searchText) { newValue in
            viewModel.performSearch(query: newValue)
        }
    }
}
