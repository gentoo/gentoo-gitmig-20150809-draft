# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gtk-gnutella/gtk-gnutella-0.93.ebuild,v 1.5 2004/03/25 08:26:27 mr_bones_ Exp $

IUSE="gnome gtk2 nls"

MY_P=${P/_r}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A GTK+ Gnutella client"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
RESTRICT="nomirror"
HOMEPAGE="http://gtk-gnutella.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="gtk2? ( =dev-libs/glib-2* =x11-libs/gtk+-2* )
	    !gtk2? ( =dev-libs/glib-1.2* =x11-libs/gtk+-1.2* )"
#DEPEND="=x11-libs/gtk+-1.2*
#	=dev-libs/glib-1.2*"
DEPEND="${DEPEND} || ( dev-util/yacc sys-devel/bison )"

src_compile() {
	if [ `use gtk2` ]; then
		GTK_VER=2
	else
		GTK_VER=1
	fi
	if [ `use nls` ]; then
		USE_NLS=y
	else
		USE_NLS=n
	fi

#	econf `use_enable gtk2`|| die "Configure failed"
	patch Configure < ${FILESDIR}/0.93-Configure.patch
	#FIXME: This should use the commandline defaults modification
	#stuff, fix this before next build
	cat << EOF | ./Configure || die "Configure Failed"




y
n
${GTK_VER}
y
/usr




${CC}


${CFLAGS}




${USE_NLS}






EOF
	emake || die "Make failed"
}

src_install () {

	make INSTALL_PREFIX=${D} install || die "Install failed"
	dodoc AUTHORS ChangeLog LICENSE MANIFEST README TODO doc
	use gnome && ( \
		insinto /usr/share/gnome/apps/Internet
		doins ${FILESDIR}/gtk-gnutella.desktop
	)
}

pkg_postinst () {
	if [ `use gtk2` ]; then
		ewarn "You have enabled the GTK2 build of gtk-gnutella, there"
		ewarn "is a known bug which causes an invalid assertion if"
		ewarn "you select passive search"
	fi
}

