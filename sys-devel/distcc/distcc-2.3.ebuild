# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/distcc/distcc-2.3.ebuild,v 1.1 2003/05/21 10:15:09 zwelch Exp $

inherit eutils

IUSE=""

HOMEPAGE="http://distcc.samba.org/"
SRC_URI="http://distcc.samba.org/ftp/distcc/distcc-${PV}.tar.bz2"
DESCRIPTION="a program to distribute compilation of C code across several machines on a network"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"

OPV="1.2"

DEPEND=">=sys-apps/portage-2.0.46-r11
	>=sys-devel/gcc-config-1.3.1
	sys-apps/shadow
	dev-libs/popt"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D%/}" install

	insinto /usr/share/doc/${PN}
	doins "${S}/survey.txt"

	exeinto /usr/bin
	doexe "${FILESDIR}/${PV}/distcc-config"

	insinto /etc/conf.d
	newins "${FILESDIR}/${OPV}/conf" distccd

	exeinto /etc/init.d
	newexe "${FILESDIR}/${OPV}/init" distccd

	# create and keep the symlink dir
	dodir /usr/lib/distcc/bin
	keepdir /usr/lib/distcc/bin

	# create the distccd pid directory
	dodir /var/run/distccd
	keepdir /var/run/distccd
}

pkg_preinst() {
	# non-/ installs don't require us to do anything here
	[ "${ROOT}" != "/" ] && return 0

	# stop daemon since script is being updated
	[ -n "$(pidof distccd)" -a -x /etc/init.d/distccd ] && \
		/etc/init.d/distccd stop

	# moved user creation and permissions to distcc-config script
	#  because of ROOT install requirements
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]; then
		einfo "Installing links to native compilers..."
		/usr/bin/distcc-config --install-user
		/usr/bin/distcc-config --install-links
		/usr/bin/distcc-config --install-links "${CHOST}"
	else
		# distcc-config can *almost* handle ROOT installs itself
		#  but for now, but user must finsh things off
		ewarn "*** Installation is not complete ***"
		ewarn "You must run the following as root:"
		ewarn "  /usr/bin/distcc-config --install"
		ewarn "after booting or chrooting into ${ROOT}"
	fi

	einfo "To use distcc with **non-Portage** C compiling, add"
	einfo "/usr/lib/distcc/bin to your path before /usr/bin.  If you're"
	einfo "combining this with ccache, put the distcc dir AFTER ccache."
	einfo "Portage 2.0.46-r11+ will take advantage of distcc if you put"
	einfo "distcc into the FEATURES setting in make.conf (and define"
	einfo "DISTCC_HOSTS as well). Do NOT set CC=distcc or similar."
	ewarn "See http://cvs.gentoo.org/~zwelch/distcc.html for information."
}

#pkg_prerm() {
#   # ztw - not sure if this is the right place
#	distcc-config --remove-links "${CHOST}"
#	distcc-config --remove-links
#}

