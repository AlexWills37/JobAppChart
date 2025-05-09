# JobAppChart

**JobAppChart** (*name subject to change*) is an iOS tool to help users organize and stay up-to-date with their job applications.

> *Disclaimer: this app does not automatically track the status of your applications (yet).*

### Organize your applications

JobAppChart provides an easy and convenient system for creating entries to represent your applications.
Just type in the position you applied to and the company's name, and you're all set!
JobAppChart will keep track of how many days it's been since you applied and make it easy to update your list when you get an application update.

You can also add a website link and additional notes, which can be viewed again at a later date by tapping on the application.

If you applied a while ago, you can easily change the date you applied so JobAppChart shows an accurate count of how long it's been since you applied.

By default, JobAppChart will display your applications grouped by their application statuses, in order from most recent to oldest.

> There is currently no way to change the organization order, but this feature is in development.

### Update your applications

Congratulations on scoring an interview!
With JobAppChart, update that application's status to *Interviewing*, and it will now show up in its own section at the top of your list.

*Done with an application?*

You can delete it if you'd like, or you can archive it in case you'd like to refer back to old applications or see some statistics, like how many jobs you applied to last month.

> *Hopefully, you landed the job and can now delete this app!*

> Currently, applications cannot be archived and there is no overview of statistics, but these features are planned for development.

## Stay on top of your job search

<!-- *Want to apply to a job every day?*

JobAppChart will send you daily reminders if you forget to apply, helping to keep you accountable.

> Notification preferences can be adjusted. -->

*Has it been a while since you heard back from a certain company?*

After a couple weeks, JobAppChart will remind you about past applications so you can follow up with copmanies, or just check the status of your application.

## Development

This project was developed with two primary goals:

- To create a tool to assist in my job search and help others in similar situations.
- To learn Swift and iOS development in preparation for a technical interview, to hopefully end my job search!
  
Because this is my first real Swift project, I'd like to reflect on the process and its learning outcomes.

### Technology

This project was developed with Swift and SwiftUI, using Xcode 16.
It also makes use of the SwiftData and Combine frameworks.

### System architecture

This project follows the MVVM pattern, separating concerns between the Views (UI components) and Models (internal/business logic), joining them together with ViewModels that handle display logic and expose the data needed by the Views through data-binding.

Combine was used to assist data-binding and reactivity, connecting the Views, ViewModels, and Models through subscriptions only to necessary fields.

SwiftData was used to store user-added information between sessions, accessed in the model layer when necessary.

#### Successes

- Implementing the MVVM pattern streamlined development and helped keep this project organized.

- With Combine, binding data between the Views and ViewModels and reacting to changing values was incredibly straightforward.
   
- SwiftData handles saving, avoiding duplicates, and data integrity with ease.

#### Challenges

- SwiftData is designed to integrate closely with the Views of an app, making the MVVM pattern less effective.
  > Models in SwiftData conform to the `Observable` protocol, so that any changes to a Model object will invalidate the Views that use it, keeping it up-to-date.
  >
  > Combine utilizes the `ObservableObject` protocol and the `@Published` attribute to create Publishers to subscribe to.
  >
  > These two systems are not entirely compatible with each other (at least in my preliminary research), and the `Observable` protocol used by SwiftData seems to primarily apply to SwiftUI Views. 
  > To ensure that the ViewModels, which are not SwiftUI Views, stay up-to-date with the SwiftData Models, some improvisation was needed.
  >
  > The ApplicationList ViewModel is a singleton, and whenever the Models are edited, such as by the ApplicationEditor, the Models are updated, and the singleton List ViewModel is instructed to update the the Model's corresponding ViewModel.

### Workflow

This project initially had a 2-week deadline. I used GitHub Projects, Issues, and Milestones to stay organized during development.

#### Ideadtion

This project, a tool to help organize job applications, is something that has been on my mind for a while. Up until now, I've been using a spreadsheet to track my job applications. I added functionality to the spreadsheet via a dropdown seelction for application statuses, a calculated *Days since application* field, and color coding based on the status, but there were always a few extra features that I wanted:

- Automatically fill in the current date when creating a new application.
- Reminders to follow up on old applications or apply to new applications.
- Better sorting/ordering for organization.

Deciding to turn this into an iOS app, I made a list of all the features that would make up my "ideal app," something worth sharing with others.

I then organized the features based on how necessary they would be to the app, putting together a set of features for the Minimum Viable Product (MVP). At its core, the MVP has the same functionality as the spreadsheet I currently use, with those initial features I wanted (easier creation process, reminders, and sorting).

I do plan on implementing all of my ideal features, but the 2-week sprint before my interview would start with the MVP.

#### Research

Alongside the ideation, I watched videos and read up on Swift, Combine, and SwiftUI.
Special thanks to [tundsdev](https://www.youtube.com/@tundsdev) and [Swiftful Thinking](https://www.youtube.com/@SwiftfulThinking), as well as [Hacking with Swift](https://www.hackingwithswift.com/) and [the Apple Developer Documentation](https://developer.apple.com/documentation) for being my primary resources for learning Swift.

In this stage I learned about SwiftData and Combine, and started to draft a system architecture to follow the MVVM pattern.

#### Planning

I then set up the GitHub repository and project page, creating issues for each of the features I was going to implement and breaking them down into sub-issues where necessary.

#### Prototyping

For the visuals of the app, I started by drafting a few designs on paper, collecting feedback from friends, and building a mockup with Figma.

I then used SwiftUI to put this design into code, making adjustments as needed.

#### Developing

Each day, I chose a feature to work on, and got to work!

Features were developed on separate branches (one at a time) and merged with a GitHub pull request, so the closed issue can be linked to the right points in the repository's history.

> Some features, like the Application Status System, proved to be more difficult than anticipated.
>
> Beyond the MVP, I wanted the system to allow users to add their own custom job statuses and custom color codes, and initially I tried making a system that would support this.
> I came to the conclusion that it would be best to store statuses and their colors with SwiftData, with a 1-to-many relationship with the Applications.
> This would mean migrating the current SwiftData schema to a new one, and implementing more code to link the Status model with the related ViewModels, as I did with the Application models.
>
> Due to the limited development time, and complete customization being beyond the scope of the MVP, I scaled this feature back to a hard-coded list of statuses with associated colors and priorities for ordering them in different Views.

#### User testing and beyond

I am not currently a member of Apple's Developer Program, but after completing development on this app, I would like to do user tests to collect feedback, make adjustments, and look into possibly publishing this app on the App Store.
