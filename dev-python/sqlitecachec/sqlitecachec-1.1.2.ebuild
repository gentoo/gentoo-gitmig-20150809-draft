# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/sqlitecachec/sqlitecachec-1.1.2.ebuild,v 1.4 2008/05/19 17:13:23 drac Exp $

inherit distutils

MY_P="yum-metadata-parser-${PV}"

DESCRIPTION="sqlite cacher for python applications"
HOMEPAGE="http://linux.duke.edu/projects/yum/"
SRC_URI="http://linux.duke.edu/projects/yum/download/yum-metadata-parser/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""

RDEPEND="=dev-libs/glib-2*
	dev-libs/libxml2
	=dev-db/sqlite-3*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${MY_P}
