# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/icecream/icecream-0.6.20050413-r1.ebuild,v 1.2 2007/01/05 22:06:55 dberkholz Exp $

inherit eutils
DESCRIPTION="Icecream is a program for distributed compiling of C(++) code across several machines based on ideas and code by distcc."
HOMEPAGE="http://en.opensuse.org/Icecream"
SRC_URI="ftp://ftp.suse.com/pub/projects/icecream/${PN}-0.6-20050413.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RDEPEND="virtual/libc
	kde? ( kde-base/kdelibs )"
DEPEND="${RDEPEND}"
IUSE="arts kde"

src_compile() {
	cd ${WORKDIR}/icecream
	epatch ${FILESDIR}/icecream-0.6-20050413-add-disable-option.patch || die "error patching icecream"
	epatch ${FILESDIR}/icecream-0.6-20050413-dont-create-symlinks.patch || die "error patching icecream"
	epatch ${FILESDIR}/icecream-0.6-20050413-gcc41.patch || die "error patching icecream"

	if ! use kde ; then
		epatch ${FILESDIR}/${PN}-0.6-20050413-no-kde.patch || die "error patching icecream"
		aclocal
		automake
		autoconf
	fi

	use amd64 && export CFLAGS="${CFLAGS} -fPIC -DPIC"
	use amd64 && export CXXFLAGS="${CXXFLAGS} -fPIC -DPIC"
	use !arts && local myconfig="--without-arts"
	./configure --prefix=/usr $myconfig
	emake || die "error compiling"
}

src_install() {
	cd ${WORKDIR}/icecream
	make DESTDIR=${D} install || die "error installing"
	newbin ${FILESDIR}/icecream-config icecream-config
	cp suse/sysconfig.icecream icecream
	insinto "/etc/conf.d"
	doins "icecream"
	newinitd ${FILESDIR}/icecream icecream
	diropts -m0755
	dodir /usr/lib/icecream/bin
	keepdir /usr/lib/icecream/bin
}

pkg_postinst() {
	enewgroup icecream || die "Problem creating icecream group"

	#are we doing bootstrap with has no useradd?
	if [ -x /usr/sbin/useradd ]; then
		enewuser icecream -1 -1 /var/cache/icecream icecream || die "Problem adding icecream user"
	else
		ewarn "You do not have useradd (bootstrap) from shadow so I didn't"
		ewarn "install the icecream user.  Note that attempting to start the daemon"
		ewarn "will fail. Please install shadow and re-emerge icecream."
		ebeep 2
	fi

	if [[ ${ROOT} = "/" ]] ; then
		einfo "Scanning for compiler front-ends..."
		/usr/bin/icecream-config --install-links
		/usr/bin/icecream-config --install-links ${CHOST}
	else
		ewarn "Install is incomplete; you must run the following command:"
		ewarn " # icecream-config --install-links ${CHOST}"
		ewarn "after booting or chrooting to ${ROOT} to complete installation."
	fi

	einfo
	einfo "If you have compiled binutils/gcc/glibc with processor-specific flags"
	einfo "(as normal using Gentoo), there is a greater chance that your compiler"
	einfo "won't work on other machines. The best would be to build gcc, glibc and"
	einfo "binutils without those flags and then copy the needed files into your"
	einfo "tarball for distribution to other machines. This tarball can be created"
	einfo "using the /usr/bin/create-env script, and used by setting ICECC_VERSION"
	einfo "in /etc/conf.d/icecream"
	einfo '  ICECC_VERSION=<filename_of_archive_containing_your_environment>'
	einfo
	einfo "To use icecream with portage add the following line to /etc/make.conf"
	einfo '  PREROOTPATH=/usr/lib/icecream/bin'
	einfo
	einfo "To use icecream with normal make use (e.g. in /etc/profile)"
	einfo '  PATH=/usr/lib/icecream/bin:$PATH'
	einfo
	einfo "N.B. To use icecream with ccache, the ccache PATH should come first:"
	einfo '  PATH=/usr/lib/ccache/bin:/usr/lib/icecream/bin:$PATH'
	einfo
	einfo "Don't forget to open the following ports in your firewall(s):"
	einfo " TCP/10245 on the daemon computers (required)"
	einfo " TCP/8765 for the the scheduler computer (required)"
	einfo " TCP/8766 for the telnet interface to the scheduler (optional)"
	einfo " UDP/8765 for broadcast to find the scheduler (optional)"
	einfo
	einfo "Further usage instructions: http://www.opensuse.org/icecream"
	einfo
}
