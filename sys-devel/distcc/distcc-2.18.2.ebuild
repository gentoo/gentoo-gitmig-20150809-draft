# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/distcc/distcc-2.18.2.ebuild,v 1.1 2004/11/15 19:40:58 lisa Exp $

# If you change this in any way please email lisa@gentoo.org and make an
# entry in the ChangeLog (this means you spanky :P). (2004-04-11) Lisa Seelye

inherit eutils gcc flag-o-matic gnuconfig

PATCHLEVEL="2.18"

DESCRIPTION="a program to distribute compilation of C code across several machines on a network"
HOMEPAGE="http://distcc.samba.org/"
SRC_URI="http://distcc.samba.org/ftp/distcc/distcc-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~ia64 ~amd64 ~s390"

IUSE="gnome gtk selinux ipv6"

DEPEND=">=sys-apps/portage-2.0.49-r6
	>=sys-devel/gcc-config-1.3.1
	sys-apps/shadow
	dev-util/pkgconfig"
RDEPEND="
	!mips? (
	gnome? (
		>=x11-libs/gtk+-2.0.0
		>=gnome-base/libgnome-2.0.0
		>=gnome-base/libgnomeui-2.0.0.0
		>=gnome-base/libglade-2.0.0
		x11-libs/pango
		>=gnome-base/gconf-2.0.0
	)
	gtk? (
		>=x11-libs/gtk+-2.0.0
		x11-libs/pango
	)
	)
	selinux? ( sec-policy/selinux-distcc )"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_compile() {
	local myconf="--with-included-popt "
	#Here we use the built in parse-options package. saves a dependancy

	#not taking any chances here, guessing which takes precedence in the 
	#configure script, so we'll just make the distinction here:
	#gnome takes precedence over gtk if both are specified (gnome pulls
	#in gtk anyways...)
	use gtk && ! use gnome && ! use mips && myconf="${myconf} --with-gtk"
	use gtk && use gnome && ! use mips && myconf="${myconf} --with-gnome"
	use mips && use gtk || use gnome && ewarn "X support for Mips has been disabled."
	#Above, mips is excluded due to version issues. 2004-02-20

	[ `gcc-major-version` -eq 2 ] && filter-lfs-flags

	if use ipv6; then
		ewarn "To use IPV6 you must have IPV6 compiled into your kernel"
		ewarn "either via a module or compiled code"
		ewarn "You can recompile without ipv6 with: USE='-ipv6' emerge distcc"
		myconf=" ${myconf} --enable-rfc2553 "
		epause 5
	fi
	einfo "${D}"
	econf ${myconf} || die "econf ${myconf} failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D%/}" install

	insinto /usr/share/doc/${PN}
	doins "${S}/survey.txt"

	exeinto /usr/bin
	doexe "${FILESDIR}/distcc-config"

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
	einfo "Setting permissions on ${ROOT}var/run/distccd"
	chown -R distcc:daemon ${ROOT}var/run/distccd
	echo ""

	einfo "Tips on using distcc with Gentoo can be found at"
	einfo "http://www.gentoo.org/doc/en/distcc.xml"
	ewarn "As of distcc-2.11, the only thing you have to do to configure distcc"
	ewarn "is to set your hosts (see the Guide, above) and to add distcc to"
	ewarn "the FEATURES line in /etc/make.conf"
	ewarn "This version includes a new distcc-config. If you encounter problems with it,"
	ewarn "please report them to our Bugzilla at bugs.gentoo.org"
	echo ""
	einfo "To use the distccmon programs with Gentoo you should use this command:"
	einfo "      DISTCC_DIR=/var/tmp/portage/.distcc distccmon-text N"
	use gnome || use gtk && einfo "Or:   DISTCC_DIR=/var/tmp/portage/.distcc distccmon-gnome"

	ewarn "***SECURITY NOTICE***"
	ewarn "If you are upgrading distcc please make sure to run etc-update to"
	ewarn "update your /etc/conf.d/distccd and /etc/init.d/distccd files with"
	ewarn "added security precautions (the --listen and --allow directives)"
	ebeep 5
}
