# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ladspa-cmt/ladspa-cmt-1.15.ebuild,v 1.7 2004/03/31 20:41:40 dholm Exp $

S="${WORKDIR}/cmt/src"
MY_P="cmt_src_${PV}"

DESCRIPTION="CMT (computer music toolkit) Lasdpa library plugins"
HOMEPAGE="http://www.ladspa.org/"
SRC_URI="http://www.ladspa.org/download/${MY_P}.tgz"

KEYWORDS="x86 ~ppc"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""

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
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	INSOPTIONS="-m755"
	insinto /usr/lib/ladspa
	doins ../plugins/*.so || die "doins failed"
	dodoc ../README       || die "dodoc failed"
	dohtml ../doc/*       || die "dohtml failed"
}
