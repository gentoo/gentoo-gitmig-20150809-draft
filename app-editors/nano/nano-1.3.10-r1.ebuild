# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nano/nano-1.3.10-r1.ebuild,v 1.3 2006/04/24 10:38:48 nelchael Exp $

#ECVS_SERVER="savannah.gnu.org:/cvsroot/nano"
#ECVS_MODULE="nano"
#ECVS_AUTH="pserver"
#ECVS_USER="anonymous"
#inherit cvs
inherit eutils

MY_P=${PN}-${PV/_}
DESCRIPTION="GNU GPL'd Pico clone with more functionality"
HOMEPAGE="http://www.nano-editor.org/"
SRC_URI="http://www.nano-editor.org/dist/v1.3/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm hppa ia64 m68k ~mips ~ppc ~ppc-macos ~ppc64 s390 sh ~sparc x86"
IUSE="build debug justify minimal ncurses nls slang spell unicode"

DEPEND=">=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )
	!ncurses? ( slang? ( sys-libs/slang ) )"
PROVIDE="virtual/editor"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-disp.patch
	epatch "${FILESDIR}"/${P}-crash.patch
}

src_compile() {
	if [[ ! -e configure ]] ; then
		./autogen.sh || die "autogen failed"
	fi

	local myconf=""
	use ncurses \
		&& myconf="--without-slang" \
		|| myconf="${myconf} $(use_with slang)"

	econf \
		--bindir=/bin \
		--enable-color \
		--enable-multibuffer \
		--enable-nanorc \
		--disable-wrapping-as-root \
		$(use_enable spell) \
		$(use_enable justify) \
		$(use_enable debug) \
		$(use_enable nls) \
		$(use_enable unicode utf8) \
		$(use_enable minimal tiny) \
		${myconf} \
		|| die "configure failed"
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	if use build ; then
		rm -rf "${D}"/usr/share
	else
		cat "${FILESDIR}"/nanorc-* >> doc/nanorc.sample
		dodoc ChangeLog README doc/nanorc.sample AUTHORS BUGS NEWS TODO
		dohtml *.html
		insinto /etc
		newins doc/nanorc.sample nanorc
	fi

	dodir /usr/bin
	dosym /bin/nano /usr/bin/nano
}

pkg_postinst() {
	einfo "More helpful info about nano, visit the GDP page:"
	einfo "http://www.gentoo.org/doc/en/nano-basics-guide.xml"
}
