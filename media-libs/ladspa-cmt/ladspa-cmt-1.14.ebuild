# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ladspa-cmt/ladspa-cmt-1.14.ebuild,v 1.2 2002/09/24 05:34:19 rphillips Exp $

DESCRIPTION="CMT (computer music toolkit) Lasdpa library plugins"
HOMEPAGE="http://www.ladspa.org/"
LICENSE="LGPL-2.1"
DEPEND="media-libs/ladspa-sdk"
RDEPEND="${DEPEND}"
SRC_URI="http://www.ladspa.org/download/cmt_src.tgz"
KEYWORDS="x86"

SLOT="0"

S=${WORKDIR}/cmt/src
P=cmt_src
A=${P}.tgz

src_unpack() {
	unpack "${A}"
	cd "${S}"
	sed -e "/^CFLAGS/ s/-O3/${CFLAGS}/" \
		-e 's|/usr/local/include||g' \
		-e 's|/usr/local/lib||g' \
		makefile > makefile.new
		mv makefile.new makefile

}
src_compile() {
        emake || die
}

src_install() {

	dodoc ../doc/*
	insinto /usr/lib/ladspa
	INSOPTIONS="-m755"
	doins ../plugins/*.so



}
																				
