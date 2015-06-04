from setuptools import setup, find_packages

setup(
    name='flaskpoc',
    version='1.0',
    long_description=__doc__,
    packages=find_packages(),
    include_package_data=True,
    zip_safe=False,
    install_requires=['Flask'],
    entry_points="""
    [console_scripts]
    flaskpoc = flaskpoc.app:main
    """,
)