# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/distcc/distcc-1.2.ebuild,v 1.1 2003/02/24 01:05:02 zwelch Exp $

inherit eutils

IUSE=""

HOMEPAGE="http://distcc.samba.org/"
SRC_URI="http://distcc.samba.org/ftp/distcc/distcc-${PV}.tar.bz2"
DESCRIPTION="a program to distribute compilation of C code across several machines on a network"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa arm"

DEPEND=">=sys-apps/portage-2.0.46-r11
	>=sys-devel/gcc-config-1.3.1
	dev-libs/popt"

src_unpack() {
	unpack distcc-${PV}.tar.bz2
#	cp -a distcc-${PV} distcc-${PV}.orig
	epatch "${FILESDIR}/${PV}/wrapper.patch"
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

	exeinto /usr/bin
	doexe "${FILESDIR}/${PV}/distcc-config"

	insinto /etc/conf.d
	newins "${FILESDIR}/${PV}/conf" distccd

	exeinto /etc/init.d
	newexe "${FILESDIR}/${PV}/init" distccd

	# create and keep the symlink dir
	dodir /usr/lib/distcc/bin
	keepdir /usr/lib/distcc/bin

	# create the distccd pid directory
	dodir /var/run/distccd
	keepdir /var/run/distccd
}

pkg_preinst() {
	# stop daemon since script is being updated
	einfo "Stopping distccd..."
	[ -x /etc/init.d/distccd ] && \
		/etc/init.d/distccd stop > /dev/null 2>&1

	# update or create, depending on whether user already exists
	einfo "Updating or creating distcc user..."
	local USERFIX
	id distcc >/dev/null 2>&1 && USERFIX=usermod || USERFIX=useradd
	${USERFIX} -g daemon -s /bin/false -d /dev/null -c "distccd" distcc || die
}

pkg_postinst() {
	local d
	for d in /usr/lib/distcc/bin /var/run/distccd ; do
		einfo "Configuring $d..."
		chown distcc:daemon $d
		chmod 0755 $d
	done

	einfo "Installing links to installed compilers..."
	/usr/bin/distcc-config --install-links
	/usr/bin/distcc-config --install-links "${CHOST}"

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

