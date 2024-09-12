//
//  ProductServiceEndpoint.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso Turkey. All rights reserved.
//

import Foundation

enum ProductServiceEndpoint: TargetEndpointProtocol {
    case searchCatalog(filters: String?,
                       pageSize: Int,
                       pageIndex: Int,
                       sortingOptionId: String?)
    case searchFacets(filters: String?,
                      pageSize: Int,
                      pageIndex: Int,
                      sortingOptionId: String?)

    // MARK: - Internal -

    var path: String {
        switch self {
        case .searchCatalog(let filters, let pageSize, let pageIndex, let sortingOptionId),
             .searchFacets(let filters, let pageSize, let pageIndex, let sortingOptionId):

            var parameterData: [String] = []

            if let filters, filters.isEmpty == false {
                parameterData.append(filters)
            }

            if let sortingOptionId {
                parameterData.append("SortOrder=\(sortingOptionId)")
            }

            parameterData.append("PageSize=\(pageSize)")
            parameterData.append("PageIndex=\(pageIndex)")

            let parameters = parameterData.joined(separator: "&")

            return BaseEndpoint.base.path + String(format: endpointPath, parameters)
        }
    }

    var endpointPath: String {
        switch self {
        case .searchCatalog:
            return "/api/Product/SearchCatalog?%@"
        case .searchFacets:
            return "/api/Product/SearchFacet?%@"
        }
    }
}
