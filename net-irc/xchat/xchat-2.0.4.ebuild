# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-irc/xchat/xchat-2.0.4.ebuild,v 1.7 2003/09/04 12:38:31 obz Exp $

inherit eutils

DESCRIPTION="X-Chat is a graphical IRC client for UNIX operating systems."
SRC_URI="http://www.xchat.org/files/source/2.0/${P}.tar.bz2"
HOMEPAGE="http://www.xchat.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha hppa"
IUSE="perl tcltk python ssl gtk mmx ipv6 nls"

# Added for to fix a sparc seg fault issue by Jason Wever <weeve@gentoo.org>
if [ ${ARCH} = "sparc" ]
then
	replace-flags "-O3" "-O2"
fi


RDEPEND=">=dev-libs/glib-2.0.3
	gtk? ( >=x11-libs/gtk+-2.0.3 )
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

	econf \
		`use_enable gtk gtkfe` \
		`use_enable ssl openssl` \
		`use_enable perl` \
		`use_enable python` \
		`use_enable tcltk tcl` \
		`use_enable mmx` \
		`use_enable ipv6` \
		`use_enable nls` \
		--enable-textfe \
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

pkg_postinst( ) {

	# warnings for people for who USE="gtk2 -gtk" doesnt behave as
	# they expect, see bug #26427
	if [ ! `use gtk` ]; then
		echo ""
		ewarn "If you wish to use the gtk2 frontend for xchat, please"
		ewarn "USE=\"gtk\" emerge xchat"
		echo ""
	fi

}
