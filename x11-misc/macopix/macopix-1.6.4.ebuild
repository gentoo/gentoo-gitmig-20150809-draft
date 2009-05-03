# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/macopix/macopix-1.6.4.ebuild,v 1.2 2009/05/03 19:00:06 arfrever Exp $

DESCRIPTION="MaCoPiX (Mascot Constructive Pilot for X) is a desktop mascot application on UNIX / X Window system."
HOMEPAGE="http://rosegray.sakura.ne.jp/macopix/index-e.html"

BASE_URI="http://rosegray.sakura.ne.jp/macopix"
SRC_URI="${BASE_URI}/${P}.tar.bz2"

# NOTE: These mascots are not redistributable on commercial CD-ROM.
# The author granted to use them under Gentoo Linux.
MY_MASCOTS="macopix-mascot-cosmos-euc-ja-1.02
	macopix-mascot-mizuiro-euc-ja-1.02
	macopix-mascot-pia2-euc-ja-1.02
	macopix-mascot-tsukihime-euc-ja-1.02
	macopix-mascot-triangle_heart-euc-ja-1.02
	macopix-mascot-comic_party-euc-ja-1.02
	macopix-mascot-kanon-euc-ja-1.02
	macopix-mascot-one-euc-ja-1.02
	macopix-mascot-marimite-euc-ja-2.20
	macopix-mascot-HxB-euc-ja-0.30"

for i in ${MY_MASCOTS} ; do
	SRC_URI="${SRC_URI} ${BASE_URI}/${i}.tar.gz"
done

# programme itself is GPL-2, and mascots are free-noncomm
LICENSE="GPL-2 free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnutls nls"

RDEPEND=">=x11-libs/gtk+-2
	>=dev-libs/glib-2
	nls? ( >=sys-devel/gettext-0.10 )
	media-libs/libpng
	gnutls? ( net-libs/gnutls )
	!gnutls? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf --with-gtk2 \
		$(use_enable nls) \
		$(use_with gnutls)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog* NEWS *README*

	# install mascots
	for d in ${MY_MASCOTS} ; do
		einfo "Installing ${d}..."
		cd "${WORKDIR}/${d}"
		insinto /usr/share/${PN}
		for i in *.mcpx *.menu ; do
			doins $i || die
		done
		insinto /usr/share/${PN}/pixmap
		for i in *.png ; do
			doins $i || die
		done
		docinto ${d}
		dodoc README.jp
	done
}
