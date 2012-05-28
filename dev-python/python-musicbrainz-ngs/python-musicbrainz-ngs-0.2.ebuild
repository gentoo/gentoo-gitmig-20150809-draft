# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-musicbrainz-ngs/python-musicbrainz-ngs-0.2.ebuild,v 1.1 2012/05/28 08:43:39 sochotnicky Exp $

EAPI=4

inherit distutils

DESCRIPTION="This library implements webservice bindings for the Musicbrainz NGS site"
HOMEPAGE="https://github.com/alastair/python-musicbrainz-ngs"
# downloaded from git tag, no proper tarballs available
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
