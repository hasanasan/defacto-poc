//
//  ProductListResponseModel.swift
//  defacto-poc
//
//  Copyright © 2024 Adesso. All rights reserved.
//

import Foundation

// MARK: - ProductListResponseModel -

// swiftlint:disable identifier_name
// swiftlint:disable type_name
// swiftlint:disable file_length

struct ProductListResponseModel: Codable {
    // MARK: - Internal -

    enum CodingKeys: String, CodingKey {
        case d
        case dataCount
        case fmsg
        case exc
        case st
        case ve
    }

    var d: D?
    let dataCount: Int?
    let fmsg: String?
    let exc: String?
    let st: Int?
    let ve: [String]?
}

extension ProductListResponseModel {
    func getCategories() -> [Sfi]? {
        d?.f?.first { $0.fk == "fx_c3" }?.sfi
    }

    func getSortingOptions() -> [P]? {
        d?.soi
    }

    func getFilteringOptions() -> [F]? {
        d?.f
    }

    func getProducts() -> [Doc]? {
        d?.doc
    }

    mutating func selectCategoryFilter(categoryId: String?) {
        if let filterIndex = (d?.f?.firstIndex { $0.fk == "fx_c3" }),
           let subfilterIndex = (d?.f?[filterIndex].sfi?.firstIndex { $0.i == categoryId })
        {
            d?.f?[filterIndex].sfi?[subfilterIndex].s = true
        }
    }

    func getSelectedFilters() -> [String: [String]] {
        var data: [String: [String]] = [:]

        for filter in d?.f ?? [] {
            guard let fk = filter.fk else {
                continue
            }

            let selectedSubfilterIds = filter.sfi?.filter { $0.s == true }.compactMap(\.i) ?? []
            if selectedSubfilterIds.isEmpty == false {
                let currentItems = data[fk] ?? []
                data[fk] = Array(Set(currentItems + selectedSubfilterIds))
            }
        }

        return data
    }

    mutating func clearSelectedFilters() {
        for (filterIndex, filter) in (d?.f ?? []).enumerated() {
            for subfilterIndex in (filter.sfi ?? []).indices {
                d?.f?[filterIndex].sfi?[subfilterIndex].s = false
            }
        }
    }
}

// MARK: - D -

struct D: Codable {
    enum CodingKeys: String, CodingKey {
        case c
        case doc
        case f
        case soi
        case cd
        case sci
        case scn
        case url
        case seoNameUrl
        case fde
        case cat
        case ru
        case wpc
        case wcac
        case pfl
        case pmin
        case pmax
    }

    let c: Int?
    let doc: [Doc]?
    var f: [F]?
    let soi: [P]?
    let cd: String?
    let sci: Int?
    let scn: String?
    let url: String?
    let seoNameUrl: String?
    let fde: Bool?
    let cat: [Cat]?
    let ru: String?
    let wpc: String?
    let wcac: Wcac?
    let pfl: [Pfl]?
    let pmin: Double?
    let pmax: Double?
}

// MARK: - Doc -

struct Doc: Codable {
    enum CodingKeys: String, CodingKey {
        case lnk
        case pid
        case pname
        case productNames
        case ppic
        case ppt
        case productPrices
        case pvdpt
        case pvcdr
        case pvcbdr
        case pvcbd
        case pvcdpt
        case pvctid
        case pvi
        case siv2
        case siv2up
        case plc
        case purl
        case campaignCategory
        case pmc
        case pcc
        case productVariantColorNames
        case shopBy
        case colors
        case color
        case brand
        case categoryLv1Names
        case categoryLv2Names
        case categoryLv3Names
        case catlv1name
        case catlv2name
        case catlv3name
        case categoriesLvl1
        case categoriesLvl2
        case categoriesLvl3
        case shelfLife
        case npbu
        case ibsp
        case dt
        case dtq
        case dtbu
        case bc
        case pvcn
        case ar
        case trc
        case cr
        case pptcr
        case createdDateTime
        case createdUserId
        case id
        case isActive
        case isDeleted
        case updatedDateTime
        case updatedUserId
        case stampImagesV2ForUnderPicture
    }

    let lnk: Lnk?
    let pid: String?
    let pname: String?
    let productNames: [ProductNames]?
    let ppic: [Ppic]?
    let ppt: Double?
    let productPrices: [ProductPrices]?
    let pvdpt: Double?
    let pvcdr: Int?
    let pvcbdr: String?
    let pvcbd: String?
    let pvcdpt: String?
    let pvctid: String?
    let pvi: Int?
    let siv2: [Siv2]?
    let siv2up: String?
    let plc: String?
    let purl: String?
    let campaignCategory: [String]?
    let pmc: String?
    let pcc: Int?
    let productVariantColorNames: [ProductVariantColorName]?
    let shopBy: String?
    let colors: [String]?
    let color: String?
    let brand: String?
    let categoryLv1Names: [String]?
    let categoryLv2Names: [String]?
    let categoryLv3Names: [String]?
    let catlv1name: String?
    let catlv2name: String?
    let catlv3name: String?
    let categoriesLvl1: [CategoriesLvl]?
    let categoriesLvl2: [CategoriesLvl]?
    let categoriesLvl3: [CategoriesLvl]?
    let shelfLife: Int?
    let npbu: String?
    let ibsp: Bool?
    let dt: String? // unknown type
    let dtq: Int?
    let dtbu: String? // unknown type
    let bc: String?
    let pvcn: [Pvcn]?
    let ar: Double?
    let trc: Double?
    let cr: Double?
    let pptcr: Double?
    let createdDateTime: String?
    let createdUserId: String?
    let id: String?
    let isActive: Bool?
    let isDeleted: Bool?
    let updatedDateTime: String?
    let updatedUserId: String? // unknown type
    let stampImagesV2ForUnderPicture: String? // unknown type
}

extension Doc {
    func getProductImageURLData() -> [URL]? {
        let urlData = ppic?
            .compactMap(\.ppp)
            .compactMap { URL(string: "https://picsum.photos/376/564.jpg?item=\($0)") } ?? []
//            .compactMap { URL(string: "\(AppConstants.CdnURL)/376/\($0)") } ?? []

        if urlData.count <= 4 {
            return urlData
        }

        return Array(urlData.prefix(upTo: 4))
    }
}

// MARK: - F -

struct F: Codable {
    // MARK: - Internal -

    enum CodingKeys: String, CodingKey {
        case displayOrder
        case fk
        case fn
        case fid
        case sfi
    }

    let displayOrder: Int?
    let fk: String?
    let fn: String?
    let fid: String?
    var sfi: [Sfi]?
}

// MARK: - Cat -

struct Cat: Codable {
    let scn: String?
    let link: Link?

    enum CodingKeys: String, CodingKey {
        case scn
        case link
    }
}

// MARK: - CategoriesLvl -

struct CategoriesLvl: Codable {
    // MARK: - Internal -

    enum CodingKeys: String, CodingKey {
        case categoryIndex
        case displayOrder
        case categoryName
        case abVariantId
    }

    let categoryIndex: Int?
    let displayOrder: String?
    let categoryName: String?
    let abVariantId: String?
}

// MARK: - Pvcn -

struct Pvcn: Codable {
    let ci: Int?
    let cn: String?
    let pvi: Int?
    let pvp: String?

    enum CodingKeys: String, CodingKey {
        case ci
        case cn
        case pvi
        case pvp
    }
}

// MARK: - Link -

struct Link: Codable {
    let lt: Int?
    let p: [P]?
    let ite: Bool?

    enum CodingKeys: String, CodingKey {
        case lt
        case p
        case ite
    }
}

// MARK: - Lnk -

struct Lnk: Codable {
    let lt: Int?
    let p: [P]?
    let ite: Bool?

    enum CodingKeys: String, CodingKey {
        case lt
        case p
        case ite
    }
}

// MARK: - P -

struct P: Codable {
    let k: String?
    let v: String?
    let amt: String?

    enum CodingKeys: String, CodingKey {
        case k
        case v
        case amt
    }
}

// MARK: - Pfl -

struct Pfl: Codable {
    let minp: String?
    let maxp: String?
    let curn: String?

    enum CodingKeys: String, CodingKey {
        case minp
        case maxp
        case curn
    }
}

// MARK: - Ppic -

struct Ppic: Codable {
    let productPictureIsDefault: Bool?
    let productPictureOrder: Int?
    let ppp: String?

    enum CodingKeys: String, CodingKey {
        case productPictureIsDefault
        case productPictureOrder
        case ppp
    }
}

// MARK: - ProductNames -

struct ProductNames: Codable {
    let languageIndex: Int?
    let productName: String?

    enum CodingKeys: String, CodingKey {
        case languageIndex
        case productName
    }
}

// MARK: - ProductPrices -

struct ProductPrices: Codable {
    enum CodingKeys: String, CodingKey {
        case currencyDisplay
        case currencyId
        case currencyName
        case currencySymbol
        case productPriceInclTax
        case productVariantDiscountedPriceInclTax
        case productVariantSortDiscountedPriceInclTax
        case productVariantSortDiscountedAppPriceInclTax
        case productVariantSortDiscountedWebPriceInclTax
        case productVariantSortDiscountedMobileWebPriceInclTax
        case updateDateTime
    }

    let currencyDisplay: String?
    let currencyId: Int?
    let currencyName: String?
    let currencySymbol: String?
    let productPriceInclTax: Double?
    let productVariantDiscountedPriceInclTax: Double?
    let productVariantSortDiscountedPriceInclTax: Double?
    let productVariantSortDiscountedAppPriceInclTax: Double?
    let productVariantSortDiscountedWebPriceInclTax: Double?
    let productVariantSortDiscountedMobileWebPriceInclTax: Double?
    let updateDateTime: String?
}

// MARK: - Siv2 -

struct Siv2: Codable {
    let sii: String?
    let sbi: String?
    let sp: String?
    let li: Int?
    let sips: [Sips]?
    let doKey: String?

    enum CodingKeys: String, CodingKey {
        case sii
        case sbi
        case sp
        case li
        case sips
        case doKey = "do"
    }
}

// MARK: - Sips -

struct Sips: Codable {
    enum CodingKeys: String, CodingKey {
        case sivm
        case sihm
        case sivati
        case sihati
        case spti
        case ssti
        case sdet
        case edet
        case stmpUrl
        case icr
        case sipsdo
    }

    let sivm: Int?
    let sihm: Int?
    let sivati: String?
    let sihati: String?
    let spti: String?
    let ssti: String?
    let sdet: String?
    let edet: String?
    let stmpUrl: String?
    let icr: Bool?
    let sipsdo: Int?
}

// MARK: - Sfi -

struct Sfi: Codable {
    // MARK: - Internal -

    enum CodingKeys: String, CodingKey {
        case c
        case displayOrder
        case fid
        case i
        case s
        case tag
        case t
    }

    let c: Int?
    let displayOrder: Int?
    let fid: String?
    let i: String?
    var s: Bool?
    let tag: String?
    let t: String?
}

// MARK: - Wcac -

struct Wcac: Codable {
    let ac: String?
    let dym: String?

    enum CodingKeys: String, CodingKey {
        case ac
        case dym
    }
}

// MARK: - ProductVariantColorName -

struct ProductVariantColorName: Codable {
    let colorIndex: Int?
    let colorName: String?
    let productVariantIndex: Int?
    let productVariantPicture: String?

    enum CodingKeys: String, CodingKey {
        case colorIndex
        case colorName
        case productVariantIndex
        case productVariantPicture
    }
}

// swiftlint:enable identifier_name
// swiftlint:enable type_name
// swiftlint:enable file_length
