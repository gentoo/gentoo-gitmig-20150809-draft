# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/distcc/distcc-1.1-r11.ebuild,v 1.4 2003/02/21 21:35:23 agriffis Exp $

inherit eutils

IUSE=""

HOMEPAGE="http://distcc.samba.org/"
SRC_URI="http://distcc.samba.org/ftp/distcc/distcc-${PV}.tar.bz2"
DESCRIPTION="a program to distribute compilation of C code across several machines on a network"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc alpha ~hppa arm"

DEPEND=">=sys-apps/portage-2.0.46-r11
	>=sys-devel/gcc-config-1.3.1
	dev-libs/popt"

src_unpack() {
	unpack distcc-${PV}.tar.bz2
	cp -a distcc-${PV} distcc-${PV}.orig
	epatch "${FILESDIR}/wrapper-${PV}.patch"
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install

	cd "${D}/usr/share/info" && rm -f distcc.info.gz

	docinto "../${PN}"
	dodoc "${S}/survey.txt"

	exeinto /etc/init.d
	newexe "${FILESDIR}/distccd.4" distccd

	# Search the PATH now that gcc doesn't live in /usr/bin
	#   ztw - this needs to be moved into an installed script so
	#    users/portage can re-run it after installing new compilers
	einfo "Scanning for compiler front-ends"
	dodir /usr/lib/distcc/bin
	diropts -m0755 -o distcc -g daemon
	keepdir /usr/lib/distcc/bin
	for a in gcc cc c++ g++ ${CHOST}-gcc ${CHOST}-c++ ${CHOST}-g++; do
		if [ -n "$(type -p ${a})" ]; then
			dosym /usr/bin/distcc /usr/lib/distcc/bin/${a}
		fi
	done

	dodir /var/run/distccd
	diropts -m0755 -o distcc -g daemon
	keepdir /var/run/distccd
}

pkg_preinst() {
	local USERFIX
	# update or create, depending on whether user already exists
	einfo "Updating or creating distcc user..."
	id distcc 2> /dev/null && USERFIX=usermod || USERFIX=useradd
	${USERFIX} -g daemon -s /bin/false -d /dev/null -c "distccd" distcc || \
		die "Failed to \`${USERFIX} distcc\` user"

	# stop daemon since script is being updated
	einfo "Stopping distccd..."
	[ -x /etc/init.d/distccd ] && \
		/etc/init.d/distccd stop > /dev/null 2>&1
}

pkg_postinst() {
	einfo "To use distcc with **non-Portage** C compiling, add"
	einfo "/usr/lib/distcc/bin to your path before /usr/bin.  If you're"
	einfo "combining this with ccache, put the distcc dir AFTER ccache."
	einfo "Portage 2.0.46-r11+ will take advantage of distcc if you put"
	einfo "distcc into the FEATURES setting in make.conf (and define"
	einfo "DISTCC_HOSTS as well). Do NOT set CC=distcc or similar."
	einfo "See http://cvs.gentoo.org/~zwelch/distcc.html for information."
}

