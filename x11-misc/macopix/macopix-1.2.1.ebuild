# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/macopix/macopix-1.2.1.ebuild,v 1.8 2008/05/05 19:45:29 drac Exp $

inherit eutils

DESCRIPTION="MaCoPiX (Mascot Constructive Pilot for X) is a desktop mascot application on UNIX / X Window system."
HOMEPAGE="http://rosegray.sakura.ne.jp/macopix/index-e.html"

BASE_URI="http://rosegray.sakura.ne.jp/macopix"
SRC_URI="${BASE_URI}/${P}.tar.bz2"

# NOTE: These mascots are not redistributable on commercial CD-ROM.
# The author granted to use them under Gentoo Linux.
MY_MASCOTS="cosmos-ja mizuiro-ja pia2-ja tsukihime-ja triangle_heart-ja comic_party-ja kanon-ja one-ja"
for i in ${MY_MASCOTS} ; do
	SRC_URI="${SRC_URI} ${BASE_URI}/${PN}-mascot-${i}-1.00.tar.gz"
done
MY_MASCOTS="${MY_MASCOTS} marimite-euc-ja-2.10"
SRC_URI="${SRC_URI} ${BASE_URI}/${PN}-mascot-marimite-euc-ja-2.10.tar.gz"

# programme itself is GPL-2, and mascots are free-noncomm
LICENSE="GPL-2 free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ppc x86"

IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2
	media-libs/libpng"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.10 )
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gentoo.diff \
		"${FILESDIR}"/${P}-nls.diff
}

src_compile() {
	econf --with-gtk2 \
		$(use_enable nls) || die
	emake || die "emake failed"
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog* NEWS *README*

	# install mascots
	for d in ${MY_MASCOTS} ; do
		cd "${WORKDIR}"/${PN}-mascot-${d}
		insinto /usr/share/${PN}
		# please ignore doins errors ...
		doins *.mcpx *.menu
		insinto /usr/share/${PN}/pixmap
		doins *.png
		docinto $d
		dodoc README.jp
	done
}
