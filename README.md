## Microsoft Teams Notify - Github Actions
---

- A Github Action to send Job Status to Microsoft Teams Channel

## Usage
- In the below stated example, separate job for `Notifications` has been created which will send the notification to the MS TEAMS CHANNEL irrespective of the build job status.
- Message to be sent can be customized as per the need, you can include other properties as well using Github Contexts.
- In order to use this, all you need is to create a Webhook in your MS TEAMS Channel, follow <a href="https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook">this link</a> for info about creating a one.
- Once you have created the webhook, just add the Webhook Address in secrets and utilise in your Action File in this manner `${{ secrets.SECRET_NAME }}`.
- Sample Usage
    
    ```
    name: Pipeline Name

    on:
    push:
        branches: [ branch_name ]
    pull_request:
        branches: [ branch_name ]
    jobs:

    build:
        runs-on: ubuntu-latest
        steps:
        - name: Demo Step
          run: docker push ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:$GITHUB_RUN_NUMBER
    notify:
        runs-on: ubuntu-latest
        if: always()
        needs: build
        steps:
        - name: Send a Notification
            id: notify
            uses: thechetantalwar/teams-notify@v2
            with:
            teams_webhook_url: ${{ secrets.TEAM_HOOK }}
            message: "Github Action Build Number ${{ github.run_number }} Completed for ${{ github.repository }} and the outcome is  ${{ needs.build.result }}."
    ```

- The above stated sample will send a message like below
    ![Sample Notification](https://github.com/thechetantalwar/teams-notify/blob/master/sample.png?raw=true)
