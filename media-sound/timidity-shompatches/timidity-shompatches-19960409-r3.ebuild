# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/timidity-shompatches/timidity-shompatches-19960409-r3.ebuild,v 1.6 2007/01/05 20:13:40 flameeyes Exp $

IUSE=""

DESCRIPTION="Matsumoto Shoji's patch collection for TiMidity(SC-55 style 10MB)"
HOMEPAGE="http://www.i.h.kyoto-u.ac.jp/~shom/timidity/shominst/shominst-0409.txt"
SRC_URI="http://www.i.h.kyoto-u.ac.jp/~shom/timidity/shominst/shominst-0409.zip"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"

RDEPEND=">=media-sound/timidity++-2.13.0-r2"

DEPEND="app-arch/unzip
	sys-apps/sed"

S=${WORKDIR}/shompats

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
	sed -i -e "s:dir /nethome/sak95/shom/lib/timidity/:dir /usr/share/timidity/shompatches/:" timidity.cfg
	sed -i -e "s:^source :source shompatches/:" timidity.cfg
	sed -i -e "s:^source :source shompatches/:" sfx.cfg
}

src_install() {
	insinto /usr/share/timidity/shompatches
	doins *.cfg

	# Install patches from subdirectories
	for d in `find . -type f -name \*.pat | sed 's,/[^/]*$,,' | sort -u`; do
		insinto /usr/share/timidity/shompatches/${d}
		doins ${d}/*.pat
	done
}

pkg_postinst() {
	elog "You must run 'timidity-update -g -s shompatches' to set this"
	elog "patchset as the default system patchset."
}
