# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.4.2.ebuild,v 1.1 2005/07/28 13:04:00 greg_g Exp $

inherit kde-dist eutils

DESCRIPTION="KDE SDK: Cervisia, KBabel, KCachegrind, Kompare, Umbrello,..."

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="subversion"

DEPEND="x86? ( dev-util/callgrind )
	media-gfx/graphviz
	sys-devel/flex
	subversion? ( dev-util/subversion )
	|| ( =sys-libs/db-4.3*
	     =sys-libs/db-4.2* )"

RDEPEND="${DEPEND}
	dev-util/cvs"

src_unpack() {
	kde_src_unpack

	# Configure patch. Applied for 3.5.
	epatch "${FILESDIR}/kdesdk-3.4-configure.patch"

	# For the configure patch.
	make -f admin/Makefile.common
}

src_compile() {
	local myconf="$(use_with subversion)"

	if has_version "=sys-libs/db-4.3*"; then
		myconf="${myconf} --with-db-name=db-4.3
		        --with-db-include-dir=/usr/include/db4.3"
	elif has_version "=sys-libs/db-4.2*"; then
		myconf="${myconf} --with-db-name=db-4.2
		        --with-db-include-dir=/usr/include/db4.2"
	fi

	kde_src_compile
}
