# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/distcc/distcc-2.12.1.ebuild,v 1.1 2004/01/09 07:42:30 lisa Exp $

inherit eutils gcc flag-o-matic
[ `gcc-major-version` -eq 2 ] && filter-flags -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE

PATCHLEVEL="2.11.1p"

HOMEPAGE="http://distcc.samba.org/"
SRC_URI="http://distcc.samba.org/ftp/distcc/distcc-${PV}.tar.bz2"
DESCRIPTION="a program to distribute compilation of C code across several machines on a network"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"


IUSE="gnome gtk selinux ipv6"


DEPEND=">=sys-apps/portage-2.0.49-r6
	>=sys-devel/gcc-config-1.3.1
	sys-apps/shadow"

RDEPEND="gnome? ( >=x11-libs/gtk+-2.0.0
		  >=gnome-base/libgnome-2.0.0
		  >=gnome-base/libgnomeui-2.0.0.0
		  >=gnome-base/libglade-2.0.0
		  x11-libs/pango
		 )
	gtk?	(
		>=x11-libs/gtk+-2.0.0
		x11-libs/pango
		)
	selinux? ( sec-policy/selinux-distcc )"

src_compile() {
	local myconf="--with-included-popt "
	#Here we use the built in parse-options package. saves a dependancy

	#not taking any chances here, guessing which takes precedence in the 
	#configure script, so we'll just make the distinction here:
	#gnome takes precedence over gtk if both are specified (gnome pulls
	#in gtk anyways...)
	use gtk && ! use gnome && myconf="${myconf} --with-gtk"
	use gtk && use gnome && myconf="${myconf} --with-gnome"

	if use ipv6; then
		ewarn "To use IPV6 you must have IPV6 compiled into your kernel"
		ewarn "either via a module or compiled code"
		myconf=" ${myconf} --enable-rfc2553 "
		sleep 2s
	fi

	econf ${myconf} || die "econf ${myconf} failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D%/}" install

	insinto /usr/share/doc/${PN}
	doins "${S}/survey.txt"

	exeinto /usr/bin
	doexe "${FILESDIR}/${PATCHLEVEL}/distcc-config"

	insinto /etc/conf.d
	newins "${FILESDIR}/${PATCHLEVEL}/conf" distccd

	exeinto /etc/init.d
	newexe "${FILESDIR}/${PATCHLEVEL}/init" distccd

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
	# handle DISTCC_HOSTS upgrade better
	local ENVFILE
	ENVFILE="${ROOT}etc/env.d/02distcc"
	[ ! -f "${ENVFILE}" ] && \
		ENVFILE="${ROOT}etc/env.d/04distcc"
	if [ -f "${ENVFILE}" ]
	then
		# save hosts to new file
		ROOT="${ROOT}"
		HOSTS=$(egrep '^DISTCC_HOSTS' "${ENVFILE}" | sed 's,[^=]*=,,')
		[ ${HOSTS} ] && ${ROOT}usr/bin/distcc-config --set-hosts ${HOSTS}
		# now remove from the file
		grep -v 'DISTCC_HOSTS' "${ENVFILE}" > "${ENVFILE}.new"
		mv "${ENVFILE}.new" "${ENVFILE}"
	fi

	if [ "${ROOT}" = "/" ]; then
		einfo "Installing links to native compilers..."
		/usr/bin/distcc-config --install
	else
		# distcc-config can *almost* handle ROOT installs itself
		#  but for now, but user must finsh things off
		ewarn "*** Installation is not complete ***"
		ewarn "You must run the following as root:"
		ewarn "  /usr/bin/distcc-config --install"
		ewarn "after booting or chrooting into ${ROOT}"
	fi
	einfo "Tips on using distcc with Gentoo can be found at"
	einfo "http://www.gentoo.org/doc/en/distcc.xml"
	ewarn "As of distcc-2.11, the only thing you have to do to configure distcc"
	ewarn "is to set your hosts (see the Guide, above) and to add distcc to"
	ewarn "the FEATURES line in /etc/make.conf"
	ewarn "This version is using a new distcc-config. If you encounter problems with it"
	ewarn "Please report errors to bug 27432 on the bugs.gentoo.org site"
	echo ""
	einfo "To use the distccmon programs with Gentoo you should use this command:"
	einfo "      DISTCC_DIR=/var/tmp/portage/.distcc distccmon-text N"
	use gnome || use gtk && einfo "Or:   DISTCC_DIR=/var/tmp/portage/.distcc distccmon-gnome"
	sleep 3s
}
