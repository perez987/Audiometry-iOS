//
//  PrintReportHelpers.swift
//  Audiometry
//
//  Shared helpers for print report functionality
//
//  Modified by perez987 on 20/09/2025.
//

import PDFKit
import SwiftUI
import UIKit

/// Helper functions for printing patient reports
enum PrintReportHelpers {
    /// Print a SwiftUI view by rendering it to PDF and presenting the iPad print dialog
    /// - Parameter content: The SwiftUI view to print
    @MainActor
    static func printReport(content: some View) -> String? {
        // Render the view to an image using ImageRenderer with explicit size
        let renderer = ImageRenderer(content: content)

        // Set explicit size for rendering (8.5" x 11" at 72 DPI)
        renderer.proposedSize = ProposedViewSize(width: 612, height: 792)
        renderer.scale = 2.0 // High quality (144 DPI)

        // Get the rendered image
        guard let image = renderer.uiImage else {
            return "unable_to_render_report".localized
        }

        // Verify the image has content
        guard image.size.width > 0, image.size.height > 0 else {
            return "invalid_rendered_report".localized
        }

        // Create a PDF document
        let pdfDocument = PDFDocument()

        // Create a PDF page from the image
        guard let pdfPage = PDFPage(image: image) else {
            return "unable_to_create_pdf".localized
        }

        // Add the page to the document
        pdfDocument.insert(pdfPage, at: 0)

        guard let pdfData = pdfDocument.dataRepresentation() else {
            return "unable_to_create_pdf".localized
        }

        let printController = UIPrintInteractionController.shared
        printController.printingItem = pdfData
        printController.present(animated: true, completionHandler: nil)
        return nil
    }
}
