# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nano/nano-1.2.5.ebuild,v 1.6 2008/05/10 10:28:58 vapier Exp $

inherit eutils

MY_P=${PN}-${PV/_}
DESCRIPTION="GNU GPL'd Pico clone with more functionality"
HOMEPAGE="http://www.nano-editor.org/"
SRC_URI="http://www.nano-editor.org/dist/v1.2/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc s390 sh sparc x86"
IUSE="nls build spell justify debug slang ncurses"

DEPEND=">=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )
	!ncurses? ( slang? ( =sys-libs/slang-1* ) )"

S=${WORKDIR}/${MY_P}

src_compile() {
	local myconf=""
	use build && myconf="${myconf} --disable-wrapping-as-root"
	use ncurses || myconf="${myconf} $(use_with slang)"

	econf \
		--bindir=/bin \
		--enable-color \
		--enable-multibuffer \
		--enable-nanorc \
		$(use_enable justify) \
		$(use_enable spell speller) \
		$(use_enable debug) \
		$(use_enable nls) \
		${myconf} \
		|| die "configure failed"
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	if use build ; then
		rm -r "${D}"/usr/share
	else
		cat "${FILESDIR}"/nanorc-* >> nanorc.sample
		dodoc ChangeLog README nanorc.sample AUTHORS BUGS NEWS TODO
		dohtml *.html
		insinto /etc
		newins nanorc.sample nanorc
	fi

	dodir /usr/bin
	dosym /bin/nano /usr/bin/nano
}
