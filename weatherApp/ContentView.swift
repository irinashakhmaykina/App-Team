//
//  ContentView.swift
//  weatherApp
//
//  Created by Irina Shakhmaykina on 10/1/25.
//

import SwiftUI

struct Hour: Identifiable{
    let id = UUID()
    var time: String
    var symbol: String
    var temp: Int
}

struct Day: Identifiable{
    let id = UUID()
    var name: String
    var symbol: String
    var high: Int
    var low: Int
}

struct HourlyForecastView: View {
        let hours: [Hour]
    var body: some View {
        ScrollView(.horizontal){
            VStack{
                HStack{
                    Image(systemName: "clock").scenePadding(.top)
                    Text("Hourly Forecast").scenePadding(.top)
                    Spacer()
                }
                .foregroundColor(.white)
                HStack{
                    ForEach(hours){ hour in
                        VStack{
                            Text(hour.time)
                            Image(systemName: hour.symbol)
                                .padding(2)
                            Text("\(hour.temp)")
                                .padding(2)
                        }
                        .symbolRenderingMode(.multicolor)
                        .foregroundColor(.white)
                        .padding()
                        
                    }
                    
                }
                
                
                
            }
            
            
            
            .background(Color.blue.gradient
                .opacity(0.4), in: RoundedRectangle(cornerRadius: 16))
            .padding()
            
            
            
        }
    }
    
}



struct WeeklyForecastView: View{
    let days: [Day]
    var body: some View{
        ScrollView{
            VStack{
                HStack{
                    Image(systemName: "calendar")
                    Text("10-Day Forecast")
                    Spacer()
                }
                .padding(10)
                
                
                VStack{
                    ForEach(days) { day in
                        HStack{
                            Text(day.name).frame(maxWidth: .infinity)
                            Image(systemName: day.symbol).frame(maxWidth: .infinity)
                            Text("\(day.low)").frame(maxWidth: .infinity, alignment: .trailing)
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.blue)
                                    .frame(width: 100, height:5)
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.cyan)
                                    .frame(width: 20, height:5)
                            }
                            Text("\(day.high)").frame(maxWidth: .infinity)
                        }
                        .symbolRenderingMode(.multicolor)
                        .frame(height: 44)
                        
                    }
                    
                }
                
                
                .foregroundColor(.white)
                
                
            }
        }
        .frame(height: 440)
        
        .foregroundColor(.white)
        .background(Color.blue
            .opacity(0.4), in: RoundedRectangle(cornerRadius: 16))
        .padding()
        
        
        
    }
    
}

struct ContentView: View{
    private let hours: [Hour] = [
        Hour(time: "now", symbol: "sun.max.fill", temp: 54),
        Hour(time: "1PM", symbol: "cloud.fill", temp: 55),
        Hour(time: "2PM", symbol: "cloud.fill", temp: 57),
        Hour(time: "3PM", symbol: "cloud.fill", temp: 53),
        Hour(time: "4PM", symbol: "sun.max.fill", temp: 51)
    ]
    private let days: [Day] = [
        Day(name: "Today", symbol: "cloud.fill", high: 57, low: 45),
        Day(name: "Mon", symbol: "cloud.fill", high: 70, low: 54),
        Day(name: "Tue", symbol: "cloud.fill", high: 52, low: 43),
        Day(name: "Wed", symbol: "cloud.drizzle.fill", high: 45, low: 33),
        Day(name: "Thu", symbol: "cloud.fill", high: 32, low: 28),
        Day(name: "Fri", symbol: "cloud.sun.fill", high: 33, low: 25),
        Day(name: "Sat", symbol: "cloud.sun.fill", high: 30, low: 23),
        Day(name: "Sun", symbol: "cloud.fill", high: 29, low: 21),
        Day(name: "Mon", symbol: "cloud.fill", high: 43, low: 30)
    ]
    
    var body: some View{
        VStack {
            VStack{
                Spacer()
                Text("Chapel Hill").font(.system(size: 30))
                Text("55").font(.system(size: 70))
                Text("Sunny")
                HStack{
                    Text("H:57")
                    Text("L:45")
                }
            }
            .padding(.top, 35)
            .foregroundColor(.white)
            Spacer()
            
            HourlyForecastView(hours: hours)
            WeeklyForecastView(days: days)
        }
        .background(
                LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            )
    }
    
}



#Preview {
    ContentView()
}
