# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/jless/jless-358.254.ebuild,v 1.6 2010/01/10 17:55:17 ulm Exp $

inherit eutils

LESS_P="less-${PV%%.*}"

DESCRIPTION="Jam less is an enhancement of less which supports multibyte character"
HOMEPAGE="http://www.flash.net/~marknu/less/ http://www.io.com/~kazushi/less/"
SRC_URI="mirror://gnu/less/${LESS_P}.tar.gz
	http://www25.big.jp/~jam/less/${LESS_P}-iso254.patch.gz"

LICENSE="|| ( GPL-2 BSD-2 )"
SLOT="0"
KEYWORDS="alpha ~hppa ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=sys-libs/ncurses-5.2"

S=${WORKDIR}/${LESS_P}

src_unpack() {
	unpack ${LESS_P}.tar.gz
	cd "${S}"
	epatch "${DISTDIR}"/${LESS_P}-iso254.patch.gz
}

src_compile() {
	econf \
		--without-cs-regex \
		--with-regex=auto \
		--enable-msb \
		--enable-jisx0213 \
		--with-editor=${EDITOR} \
		|| die

	emake || die
}

src_install() {
	einstall binprefix=j manprefix=j || die

	newbin "${FILESDIR}"/lesspipe.sh-r1 jlesspipe.sh

	doenvd "${FILESDIR}"/70jless

	dodoc NEWS README*
}

pkg_postinst() {
	if [ ! -f "${ROOT}"/usr/bin/lesspipe.sh ] ; then
		ln -s /usr/bin/jlesspipe.sh "${ROOT}"/usr/bin/lesspipe.sh
	fi
}
