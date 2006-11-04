# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/macopix/macopix-1.4.1.ebuild,v 1.1 2006/11/04 17:13:23 usata Exp $

inherit eutils

DESCRIPTION="MaCoPiX (Mascot Constructive Pilot for X) is a desktop mascot application on UNIX / X Window system."
HOMEPAGE="http://rosegray.sakura.ne.jp/macopix/index-e.html"

BASE_URI="http://rosegray.sakura.ne.jp/macopix"
SRC_URI="${BASE_URI}/${P}.tar.bz2"

# NOTE: These mascots are not redistributable on commercial CD-ROM.
# The author granted to use them under Gentoo Linux.
MY_MASCOTS="macopix-mascot-cosmos-ja-1.00
	macopix-mascot-mizuiro-ja-1.00
	macopix-mascot-pia2-ja-1.00
	macopix-mascot-tsukihime-ja-1.00
	macopix-mascot-triangle_heart-ja-1.00
	macopix-mascot-comic_party-ja-1.00
	macopix-mascot-kanon-ja-1.00
	macopix-mascot-one-ja-1.00
	macopix-mascot-marimite-euc-ja-2.20
	macopix-mascot-HxB-euc-ja-0.10"
for i in ${MY_MASCOTS} ; do
	SRC_URI="${SRC_URI} ${BASE_URI}/${i}.tar.gz"
done

# programme itself is GPL-2, and mascots are free-noncomm
LICENSE="GPL-2 free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="nls"

DEPEND=">=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0
	nls? ( >=sys-devel/gettext-0.10 )
	dev-util/pkgconfig
	media-libs/libpng"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.2.1-nls.diff
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
		cd ${WORKDIR}/${d/-1.00/}
		insinto /usr/share/${PN}
		# please ignore doins errors ...
		doins *.mcpx *.menu
		insinto /usr/share/${PN}/pixmap
		doins *.png
		docinto $d
		dodoc README.jp
	done
}
