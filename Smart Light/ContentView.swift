//
//  ContentView.swift
//  Smart Light
//
//  Created by Ricky Vishwas on 20/11/25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: SmartLightViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                
                // Status text
                Text(viewModel.isLoading ? "Connecting..." : (viewModel.isOn ? "Light is ON" : "Light is OFF"))
                    .font(.title)
                    .padding()
                
                // Toggle Button
                Button(action: {
                    viewModel.toggle()
                }) {
                    VStack {
                        Image(systemName: viewModel.isOn ? "lightbulb.fill" : "lightbulb")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .padding()
                        
                        Text(viewModel.isOn ? "Turn OFF" : "Turn ON")
                            .font(.headline)
                            .padding(.top, 4)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).stroke(lineWidth: 2))
                }
                
                // Last seen time
                if let last = viewModel.lastSeen {
                    Text("Last seen: \(last.formatted(date: .abbreviated, time: .shortened))")
                        .font(.caption)
                }
                
                // Error message
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("Smart Light")
        }
    }
}



#Preview {
    ContentView(viewModel: SmartLightViewModel(deviceId: "smart_light"
))
}




