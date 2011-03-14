# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/remoteobjects/remoteobjects-99999999.ebuild,v 1.1 2011/03/14 01:50:04 vapier Exp $

inherit distutils

if [[ ${PV} == "99999999" ]] ; then
	EGIT_REPO_URI="git://github.com/LegNeato/remoteobjects.git"
	inherit git
fi

DESCRIPTION="subclassable Python objects for working with JSON REST APIs"
HOMEPAGE="https://github.com/LegNeato/remoteobjects"

LICENSE="BSD"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-python/simplejson
	dev-python/httplib2"
