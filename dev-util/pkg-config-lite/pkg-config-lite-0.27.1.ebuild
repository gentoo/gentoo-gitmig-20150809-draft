# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkg-config-lite/pkg-config-lite-0.27.1.ebuild,v 1.1 2012/07/13 09:44:06 ssuominen Exp $

EAPI=4
inherit versionator

MY_P=$(version_format_string '${PN}-$1.$2-$3')

DESCRIPTION="pkg-config with internal copy of glib library"
HOMEPAGE="http://sourceforge.net/projects/pkgconfiglite/"
SRC_URI="mirror://sourceforge/pkgconfiglite/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="elibc_FreeBSD"

DEPEND=""
RDEPEND="${DEPEND}
	!dev-util/pkgconf[pkg-config]
	!dev-util/pkgconfig
	!dev-util/pkgconfig-openbsd[pkg-config]"

S=${WORKDIR}/${MY_P}

DOCS="AUTHORS ChangeLog NEWS README README.pkg-config-lite"

src_configure() {
	local myconf

	# Force using all the requirements when linking, so that needed -pthread
	# lines are inherited between libraries
	use elibc_FreeBSD && myconf+=' --enable-indirect-deps'

	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF}/html \
		--disable-silent-rules \
		${myconf}
}
