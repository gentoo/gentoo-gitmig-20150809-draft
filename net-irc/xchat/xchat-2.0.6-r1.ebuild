# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-2.0.6-r1.ebuild,v 1.7 2004/04/05 15:04:17 zul Exp $

inherit flag-o-matic

DESCRIPTION="Graphical IRC client"
SRC_URI="http://www.xchat.org/files/source/2.0/${P}.tar.bz2"
HOMEPAGE="http://www.xchat.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ~ppc sparc ~alpha hppa amd64"
IUSE="perl tcltk python ssl mmx ipv6 nls"
# Local use flag for the text frontend (bug #26427)
IUSE="${IUSE} xchattext xchatnogtk"

# Added for to fix a sparc seg fault issue by Jason Wever <weeve@gentoo.org>
if [ ${ARCH} = "sparc" ]
then
	replace-flags "-O3" "-O2"
fi


RDEPEND=">=dev-libs/glib-2.0.3
	!xchatnogtk? ( >=x11-libs/gtk+-2.0.3 )
	perl? ( >=dev-lang/perl-5.6.1 )
	ssl? ( >=dev-libs/openssl-0.9.6d )
	python? ( dev-lang/python )
	tcltk? ( dev-lang/tcl )
	nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.7"

src_compile() {

	# xchat's configure script uses sys.path to find library path
	# instead of python-config (#25943)
	unset PYTHONPATH

	# test for local usage of xchatnogtk
	local gtkconf
	use xchatnogtk \
		&& gtkconf="--disable-gtkfe" \
		|| gtkconf="--enable-gtkfe"

	# Fix for sock5 vulnerability - see 46856
	epatch ${FILESDIR}/xc208-fixsocks5.diff

	econf \
		${gtkconf} \
		`use_enable ssl openssl` \
		`use_enable perl` \
		`use_enable python` \
		`use_enable tcltk tcl` \
		`use_enable mmx` \
		`use_enable ipv6` \
		`use_enable nls` \
		`use_enable xchattext textfe` \
		--program-suffix=-2 \
		|| die "Configure failed"

	MAKEOPTS="-j1" emake || die "Compile failed"

}

src_install() {

	# some magic to create a menu entry for xchat 2
	mv xchat.desktop xchat.desktop.old
	sed -e "s:Exec=xchat:Exec=xchat-2:" -e "s:Name=XChat IRC:Name=XChat 2 IRC:" xchat.desktop.old > xchat.desktop

	einstall install || die "Install failed"

	# install plugin development header
	insinto /usr/include/xchat
	doins src/common/xchat-plugin.h

	dodoc AUTHORS COPYING ChangeLog README*

}

src_unpack() {
	unpack ${A}
	cd ${S}

	# (Dec 12 2003 solar@gentoo) Bug #35623
	# fix malformed dcc send bug.
	# discovered by lloydbates Martin Wienold of University of Dortmund - Germany in #gentoo/#gentoo.de 
	# orig patch credits go to jcdutton
	# secondary patch credits go to rac@gentoo which process the malformed dcc requests accordingly.
	epatch ${FILESDIR}/${PN}-2.0.6-fix_dccsend.patch
}
