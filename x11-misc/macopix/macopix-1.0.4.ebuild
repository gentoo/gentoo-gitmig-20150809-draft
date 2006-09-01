# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/macopix/macopix-1.0.4.ebuild,v 1.6 2006/09/01 17:29:07 genstef Exp $

DESCRIPTION="MaCoPiX (Mascot Constructive Pilot for X) is a desktop mascot application on UNIX / X Window system."
HOMEPAGE="http://rosegray.sakura.ne.jp/macopix/index-e.html"

BASE_URI="http://rosegray.sakura.ne.jp/macopix"
SRC_URI="${BASE_URI}/${P}.tar.bz2"

# NOTE: These mascots are not redistributable on commercial CD-ROM.
# The author granted to use them under Gentoo Linux.
MY_MASCOTS="cosmos mizuiro pia2 tsukihime triangle_heart comic_party kanon one"
for i in ${MY_MASCOTS} ; do
	SRC_URI="${SRC_URI} ${BASE_URI}/${PN}-mascot-${i}-ja-1.00.tar.gz"
done
MY_MASCOTS="${MY_MASCOTS} marimite"
SRC_URI="${SRC_URI} ${BASE_URI}/${PN}-mascot-marimite-ja-1.20.tar.gz"

# programme itself is GPL-2, and mascots are free-noncomm
LICENSE="GPL-2 free-noncomm"
SLOT="0"
KEYWORDS="x86 ppc"

IUSE="nls"

DEPEND=">=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0
	nls? ( >=sys-devel/gettext-0.10 )
	media-libs/libpng"

src_compile() {
	econf --with-gtk2 \
		`use_enable nls` || die
	emake || die "emake failed"
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog* NEWS *README*

	# install mascots
	for d in ${MY_MASCOTS} ; do
		cd ${WORKDIR}/${PN}-mascot-${d}-ja
		insinto /usr/share/${PN}
		# please ignore doins errors ...
		doins *.mcpx *.menu
		insinto /usr/share/${PN}/pixmap
		doins *.png
		docinto $d
		dodoc README.jp
	done
}
