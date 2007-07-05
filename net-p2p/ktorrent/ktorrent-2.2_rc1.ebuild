# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/ktorrent/ktorrent-2.2_rc1.ebuild,v 1.3 2007/07/05 17:21:08 philantrop Exp $

inherit kde

MY_P="${P/_/}"
MY_PV="${PV/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A BitTorrent program for KDE."
HOMEPAGE="http://ktorrent.org/"
SRC_URI="http://ktorrent.org/downloads/${MY_PV}/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="kdeenablefinal"

DEPEND="dev-libs/gmp"

need-kde 3.4

LANGS="ar bg br ca cs cy da de el en_GB es et fa fr gl hu it ja ka lt
ms nds nl pa pl pt pt_BR ru rw sk sr sr@Latn sv tr uk zh_CN zh_TW"

for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

src_unpack() {
	kde_src_unpack

	# Patches provided by upstream. Fix bug 182727.
	epatch ${FILESDIR}/${P}-xfs-delalloc-parens-fix.patch
	epatch ${FILESDIR}/${P}-xfs-delalloc-confighdrs-fix.patch

	local MAKE_LANGS
	cd "${WORKDIR}/${MY_P}/translations"
	for X in ${LANGS} ; do
		use linguas_${X} && MAKE_LANGS="${MAKE_LANGS} ${X}"
	done
	rm -f ${S}/configure
	sed -i -e "s:SUBDIRS=.*:SUBDIRS=${MAKE_LANGS}:" Makefile.am
}

src_compile(){
	local myconf="--enable-knetwork"
	kde_src_compile
}
