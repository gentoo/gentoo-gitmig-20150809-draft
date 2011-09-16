# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/obs-download.eclass,v 1.1 2011/09/16 15:49:19 miska Exp $

# @ECLASS: obs-download.eclass
# @MAINTAINER:
# miska@gentoo.org
# @BLURB: Simplifies downloading from openSUSE Build Service.
# @DESCRIPTION:
# This eclass constructs OBS_URI based on provided project in openSUSE Build
# Service and package name. It can be used by packages/eclasses to download
# actual files.
#
# All you need to do in order to use it is set OBS_PROJECT and OBS_PACKAGE and
# inherit this eclass. It will provide OBS_URI in return which you will prepend
# to your files and use it in SRC_URI. Alternatively you can just set
# OPENSUSE_RELEASE and OBS_PACKAGE and it will give you back OBS_URI for
# downloading files from obs project corresponding to the specified openSUSE
# release.

# @ECLASS-VARIABLE: OPENSUSE_RELEASE
# @DEFAULT_UNSET
# @DESCRIPTION:
# From which stable openSUSE realease to take files.

# @ECLASS-VARIABLE: OBS_PROJECT
# @DEFAULT_UNSET
# @DESCRIPTION:
# In which obs project pakage is. This variable don't have to be set, if
# OPENSUSE_RELEASE is provided.

# @ECLASS-VARIABLE: OBS_PACKAGE
# @REQUIRED
# @DESCRIPTION:
# Name of the package we want to take files from.

[[ -z ${OPENSUSE_RELEASE} ]] || OBS_PROJECT="openSUSE:${OPENSUSE_RELEASE}"
[[ -n ${OBS_PROJECT} ]]      || die "OBS_PROJECT not set!"
[[ -n ${OBS_PACKAGE} ]]      || die "OBS_PACKAGE not set!"

OBS_URI="https://api.opensuse.org/public/source/${OBS_PROJECT}/${OBS_PACKAGE}"
