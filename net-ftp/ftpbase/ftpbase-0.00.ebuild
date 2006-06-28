# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/ftpbase/ftpbase-0.00.ebuild,v 1.14 2006/06/28 02:49:47 vapier Exp $

inherit eutils pam

DESCRIPTION="FTP layout package"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE="pam"

DEPEND="pam? ( || ( virtual/pam sys-libs/pam ) )
	!<net-ftp/proftpd-1.2.10-r6
	!<net-ftp/pure-ftpd-1.0.20-r2
	!<net-ftp/vsftpd-2.0.3-r1"

S="${WORKDIR}"

check_collision() {
	[[ ! -e "$1" ]] && return 0

	[[ $( head -n 1 "$1" ) == "$( head -n 1 "$2" )" ]] && return 0

	eerror "   $1 exists and was not provided by ${P}"
	return 1
}

pkg_setup() {
	ebegin "Checking for possible file collisions..."

	local collide=false
	check_collision /etc/ftpusers "${FILESDIR}/ftpusers" || collide=true

	if use pam ; then
		check_collision /etc/pam.d/ftp "${FILESDIR}/ftp-pamd" || collide=true
	fi

	if ${collide} ; then
		echo
		einfo "Those files listed above have to be removed in order to"
		einfo "install this version of ftpbase."
		echo
		ewarn "If you edited them, remember to backup and when restoring make"
		ewarn " sure the first line in each file is:"
		einfo "$( head -n 1 "${FILESDIR}/ftpusers" )"
		eend 1
		die "Can't be installed, files will collide"
	fi

	eend 0

	# Add our default ftp user
	enewgroup ftp 21
	enewuser ftp 21 -1 /home/ftp ftp
}

src_install() {
	# The ftpusers file is a list of people who are NOT allowed
	# to use the ftp service.
	insinto /etc
	doins "${FILESDIR}/ftpusers"

	# Ideally we would create the home directory here with a dodir.
	# But we cannot until bug #9849 is solved - so we kludge in pkg_postinst()

	if use pam ; then
		if has_version "<sys-libs/pam-0.78" ; then
			newpamd "${FILESDIR}/ftp-pamd" ftp
		else
			newpamd "${FILESDIR}/ftp-pamd-include" ftp
		fi
	fi
}

pkg_postinst() {
	# Create our home directory if it doesn't exist and give a warning if we
	# cannot.
	# Install manually using install -d until bug #9849 is solved.
	# This means that the home directory will not be removed when we uninstall
	# if it's empty.
	local homedir="$(egethome ftp)"
	if [[ ! -d "${homedir}" ]]; then
		einfo "Creating home directory for ftp user"
		einfo "   ${homedir}"
		install -d "${homedir}" \
	    	|| ewarn "  can't create ${homedir}"
	fi
}
