![A cover image for the Parody package containing the command docker run -tip 80:8080 aschmelyun/parody:latest](/images/cover.png)

# Parody

Create a fully-featured test API with authentication included, zero coding required.

## Documentation

The only requirement needed for Parody is Docker. Follow [these instructions](https://docs.docker.com/get-started) to get started setting it up for your system, and then clone or download this repo on your machine of choice.

After that, running the following command will create a basic test API at [localhost](http://localhost):

```bash
docker run -tip 80:8080 aschmelyun/parody:latest
```

The output of the server will be streamed to your console. You can prevent this by using the `-d` flag in the above command, and using `ctrl+c` will stop the container and bring down your API.

## Technology

This is built with the help of a wide range of open source projects:

- [Laravel](https://laravel.com)
- [Laravel Blueprint](https://blueprint.laravelshift.com)
- [Laravel Sanctum](https://github.com/laravel/sanctum)
- [MariaDB](https://mariadb.org)
- [Alpine Linux](https://alpinelinux.org)

## Todo

Parody is still very much a work in progress. The following are features that are either currently in the works or planned to be added:

- [] Authentication layer with Laravel Sanctum
- [] Multiple project types set through an env value on the container
- [] Testable email notifications with Mailtrap
- [] Simplify Docker flow with a wrapper script
- [] Adjust amount of seeded database items through env values