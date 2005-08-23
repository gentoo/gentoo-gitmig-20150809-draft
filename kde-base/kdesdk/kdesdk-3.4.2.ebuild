# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesdk/kdesdk-3.4.2.ebuild,v 1.5 2005/08/23 07:52:55 greg_g Exp $

inherit kde-dist eutils

DESCRIPTION="KDE SDK: Cervisia, KBabel, KCachegrind, Kompare, Umbrello,..."

KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~hppa"
IUSE="berkdb subversion"

DEPEND="x86? ( dev-util/callgrind )
	sys-devel/flex
	subversion? ( dev-util/subversion )
	berkdb? ( || ( =sys-libs/db-4.3*
	               =sys-libs/db-4.2* ) )"

RDEPEND="${DEPEND}
	dev-util/cvs
	media-gfx/graphviz"

src_unpack() {
	kde_src_unpack

	# Configure patch. Applied for 3.5.
	epatch "${FILESDIR}/kdesdk-3.4-configure.patch"

	# For the configure patch.
	make -f admin/Makefile.common
}

src_compile() {
	local myconf="$(use_with subversion)"

	if use berkdb; then
		if has_version "=sys-libs/db-4.3*"; then
			myconf="${myconf} --with-berkeley-db --with-db-name=db-4.3
			        --with-db-include-dir=/usr/include/db4.3"
		elif has_version "=sys-libs/db-4.2*"; then
			myconf="${myconf} --with-berkeley-db --with-db-name=db-4.2
			        --with-db-include-dir=/usr/include/db4.2"
		fi
	else
		myconf="${myconf} --without-berkeley-db"
	fi

	kde_src_compile
}
