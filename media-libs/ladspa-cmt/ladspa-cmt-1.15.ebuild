# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ladspa-cmt/ladspa-cmt-1.15.ebuild,v 1.21 2005/12/30 23:29:18 flameeyes Exp $

inherit eutils

IUSE=""

S="${WORKDIR}/cmt/src"
MY_P="cmt_src_${PV}"

DESCRIPTION="CMT (computer music toolkit) Lasdpa library plugins"
HOMEPAGE="http://www.ladspa.org/"
SRC_URI="http://www.ladspa.org/download/${MY_P}.tgz"

KEYWORDS="x86 ppc amd64 sparc ppc-macos"
LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="media-libs/ladspa-sdk
	>=sys-apps/sed-4"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	sed -i \
		-e "/^CFLAGS/ s/-O3/${CFLAGS}/" \
		-e 's|/usr/local/include||g' \
		-e 's|/usr/local/lib||g' makefile \
			|| die "sed makefile failed"

	cd "${S}"
	use userland_Darwin && epatch ${FILESDIR}/${PN}-darwin.patch
	# gcc-4 bails
	sed -i -e 's|-Werror||g' makefile \
		|| die "sed makefile failed"
}

src_compile() {
	# It sets CXXFLAGS to CFLAGS, can be wrong..
	# Just set CXXFLAGS to what they should be
	emake CXXFLAGS="$CXXFLAGS -I. -fPIC" || die
}

src_install() {
	insopts -m755
	insinto /usr/$(get_libdir)/ladspa
	doins ../plugins/*.so || die "doins failed"
	dodoc ../README       || die "dodoc failed"
	dohtml ../doc/*       || die "dohtml failed"
}
