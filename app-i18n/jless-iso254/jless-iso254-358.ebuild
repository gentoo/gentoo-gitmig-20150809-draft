# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/jless-iso254/jless-iso254-358.ebuild,v 1.10 2004/04/06 03:55:09 vapier Exp $

inherit eutils

LESS_P="less-${PV}"

DESCRIPTION="Jam less is an enhancement of less which supports multibyte character"
HOMEPAGE="http://www.flash.net/~marknu/less/ http://www.io.com/~kazushi/less/"
SRC_URI="mirror://gnu/less/${LESS_P}.tar.gz
	http://www.io.com/~kazushi/less/${LESS_P}-iso254.patch.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2"

S=${WORKDIR}/${LESS_P}

src_unpack() {

	unpack ${LESS_P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/${LESS_P}-iso254.patch.gz
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

	newbin ${FILESDIR}/lesspipe.sh-r1 jlesspipe.sh
	if [ ! -f ${ROOT}/usr/bin/lesspipe.sh ] ; then
		dosym /usr/bin/jlesspipe.sh /usr/bin/lesspipe.sh
	fi

	insinto /etc/env.d
	doins ${FILESDIR}/70jless

	dodoc NEWS README*
}

pkg_postinst() {
	# for backward compatibility
	if [ ! -f ${ROOT}/usr/bin/lesspipe.sh ] ; then
		ln -s /usr/bin/jlesspipe.sh ${ROOT}/usr/bin/lesspipe.sh
	fi
}
