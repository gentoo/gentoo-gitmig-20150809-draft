# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/ciphire-mail/ciphire-mail-1.2.047.ebuild,v 1.4 2007/07/02 14:59:32 peper Exp $

inherit eutils qt3

LOC="/opt/ciphire-mail"
DESCRIPTION="Ciphire Mail is an email encryption tool, operating seamlessly in the background."
HOMEPAGE="http://www.ciphire.com/"
SRC_URI="${P}-linux-i686.tar.gz
	amd64? ( ciphire-redir64.so )"
LICENSE="Ciphire"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="strip fetch mirror"
IUSE="X gnome kde"

DEPEND=
RDEPEND="|| ( ( x11-libs/libSM
				x11-libs/libXext )
			virtual/x11 )
	x86? ( $(qt_min_version 3.2) )
	amd64? ( >=app-emulation/emul-linux-x86-baselibs-2.1.1
			 >=app-emulation/emul-linux-x86-xlibs-1.2
			 >=app-emulation/emul-linux-x86-qtlibs-1.1 )"
# We need X and QT regardless, as the USE=X is more just for the session
# wrappers, etc.

pkg_nofetch() {
	einfo "You need to perform the following steps to install this package:"
	einfo " - Go here:  https://www.ciphire.com/linux_download.html,"
	einfo " - Download: ${P}-linux-i686.tar.gz"
	einfo "   and place it in ${DISTDIR}"
	echo
	if useq amd64 ; then
		ewarn " - Go here: https://forum.ciphire.com/viewtopic.php?p=4173:"
		ewarn " - Download: ciphire-redir64.so"
		ewarn "   and place it in ${DISTDIR}"
		echo
	fi
	einfo " - emerge this package again"
	echo
}

pkg_setup() {
	if ( [[ -d /usr/local/ciphire ]] || type -p ciphire-ctl &>/dev/null ) && \
	   ! has_version / ciphire-mail ; then
		echo
		eerror "If you have previously had Ciphire Mail manually installed,"
		eerror "please uninstall it first (from dir you installed it):"
		eerror
		eerror "  # ./ciphire-uninstall system"
		eerror
		eerror "and then remerge ciphire-mail."
		echo
		die "Old version of ciphire-mail installed"
	fi

	check_license Ciphire
}

src_unpack() {
	unpack "${P}-linux-i686.tar.gz"

	# Do not run 'more' to show the license - we already handle it with
	# check_license() in pkg_setup() ...
	sed -i -e 's:more\(.*\$LICENSE_FILE\):echo\1:' \
		"${S}/files/setupdata/libciphire.sh"
}

src_install() {
	local x=

	dodir "${LOC}"
	keepdir "${LOC}/updates" "${LOC}/user_default/updates"

	# Do not enable the graphical popups
	env -u DISPLAY \
	./install-ciphire.sh "${D}${LOC}" <<-EOF
		en
		n
		yes
		y
		n
		n
	EOF
	[[ "$?" != 0 ]] && die "install-ciphire.sh failed"

	# Revert the change in src_unpack()
	dosed -e 's:echo\(.*\$LICENSE_FILE\):more\1:' \
		"${LOC}"/setupdata/libciphire.sh

	# Fixup $D in setupdata
	for x in "${D}${LOC}"/setupdata/*; do
		sed -i -e "s:${D}::g" "${x}"
	done

	if useq amd64 ; then
		# Install 64bit ciphire-redir.so
		exeinto "${LOC}"
		doexe "${DISTDIR}"/ciphire-redir64.so
		# Make sure the redirector gets used.
		dosed -e \
			'/PRELOAD_VALUE=/ s|\$CITARGET/ciphire-redir.so|\$CITARGET/ciphire-redir64.so:\$CITARGET/ciphire-redir.so|' \
			"${LOC}"/ciphire-systemsetup
		[[ -z $(grep 'ciphire-redir64.so' "${D}${LOC}/ciphire-systemsetup") ]] && \
			die "Could not add 'ciphire-redir64.so'!"
	fi

	# Enable X support
	useq X && dosed -e 's:^XSUPPORT=.*:XSUPPORT=1:' \
		"${LOC}"/setupdata/ciphire.distconfig

	cm_make_wrapper ciphire-setup ciphire-setup "${LOC}"
	cm_make_wrapper ciphire-ctl ciphire-ctl "${LOC}"
	cm_make_wrapper ciphire-msg ciphire-msg "${LOC}"

	if useq X && ( useq gnome || useq kde ) ; then
		make_desktop_entry ciphire-setup \
			"Ciphire Mail User Setup" \
			"${LOC}"/data/logo32.png \
			"Network" \
			"${LOC}"
	fi
}

pkg_postinst() {
	if [[ ${ROOT} == "/" ]] ; then
		useq X && env -u DISPLAY "${LOC}"/ciphire-systemsetup xreinstall \
		      || env -u DISPLAY "${LOC}"/ciphire-systemsetup reinstall
	fi

	echo
	elog "To setup Ciphire Mail for a user, please run as that user:"
	elog
	elog "  ${LOC}/ciphire-setup"
	elog
	elog "If you have previously had Ciphire Mail manually installed,"
	elog "please uninstall it first (from dir you installed it):"
	elog
	elog "  # ./ciphire-uninstall system"
	elog
	elog "and then remerge ciphire-mail."
	echo
	if useq amd64 ; then
		ewarn "Please note that the AMD64 support (ciphire-redir64.so) is"
		ewarn "Beta, and not officially supported!"
		echo
		ebeep
	fi
}

cm_make_wrapper() {
	local wrapper=$1 bin=$2 dir=$3
	local tmpwrapper=$(emktemp)

	cat << EOF > "${tmpwrapper}"
#!/bin/bash

exec ${dir}/${bin} "\$@"
EOF
	chmod go+rx "${tmpwrapper}"
	if [[ -n $5 ]] ; then
		exeinto "${5}"
		newexe "${tmpwrapper}" "${wrapper}"
	else
		newbin "${tmpwrapper}" "${wrapper}"
	fi
}

