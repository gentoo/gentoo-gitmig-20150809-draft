# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/ciphire-mail/ciphire-mail-1.0.0.ebuild,v 1.1 2005/07/13 18:53:57 azarah Exp $

inherit eutils

LOC="/opt/ciphire-mail"
DESCRIPTION="Ciphire Mail is an email encryption tool, operating seamlessly in the background."
HOMEPAGE="http://www.ciphire.com/"
SRC_URI="${P}-linux-i686.tar.gz"
LICENSE="Ciphire"
SLOT="0"
# Do not support amd64 as yet, as we need 64bit support
KEYWORDS="-* ~x86 -amd64"
RESTRICT="nostrip fetch nomirror"
IUSE="X gnome kde"

DEPEND=
RDEPEND="X? ( virtual/x11 )
	x86? ( >=x11-libs/qt-3.2 )
	amd64? ( app-emulation/emul-linux-x86-glibc
			 >=app-emulation/emul-linux-x86-baselibs-2.1.1
			 X? ( >=app-emulation/emul-linux-x86-xlibs-1.2
			      >=app-emulation/emul-linux-x86-qtlibs-1.1 ) )"

pkg_nofetch() {
	einfo "You need to perform the following steps to install this package:"
	einfo " - Go here:  https://www.ciphire.com/linux_download.html,"
	einfo " - download ${A} and place it in ${DISTDIR}"
	einfo " - emerge this package again"
}

pkg_setup() {
	if ( [[ -d /usr/local/ciphire ]] || type -p ciphire-ctl &>/dev/null ) && \
	   ! portageq has_version / ciphire-mail ; then
		echo
		einfo "If you have previously had Ciphire Mail manually installed,"
		einfo "please uninstall it first (from dir you installed it):"
		echo
		einfo "  # ./ciphire-uninstall system"
		echo
		einfo "and then remerge ciphire-mail."
		echo
		die "Old version of ciphire-mail installed"
	fi

	check_license || die "License check failed"
}

src_unpack() {
	unpack "${A}"

	# Do not run 'more' to show the license
	sed -i -e 's:more\(.*LICENSE.txt\):echo\1:' \
		"${S}/files/setupdata/libciphire.sh"
}

src_install() {
	local x=

	dodir "${LOC}"
	keepdir "${LOC}/updates"
	# Do not enable the graphical popups
	env -u DISPLAY \
	./install-ciphire.sh "${D}${LOC}" <<-EOF
		n
		yes
		y
		n
		n
	EOF
	[[ "$?" != 0 ]] && die "install-ciphire.sh failed"

	# Revert the change in src_unpack()
	dosed -e 's:echo\(.*LICENSE.txt\):more\1:' \
		"${LOC}"/setupdata/libciphire.sh

	# Fixup $D in setupdata
	for x in "${D}${LOC}"/setupdata/*; do
		sed -i -e "s:${D}::g" "${x}"
	done

	# Enable X support
	use X && dosed -e 's:^XSUPPORT=.*:XSUPPORT=1:' \
		"${LOC}"/setupdata/ciphire.distconfig

	cm_make_wrapper ciphire-setup ciphire-setup "${LOC}"
	cm_make_wrapper ciphire-ctl ciphire-ctl "${LOC}"
	cm_make_wrapper ciphire-msg ciphire-msg "${LOC}"

	if use X && ( use gnome || use kde ) ; then
		make_desktop_entry ciphire-setup \
			"Ciphire Mail User Setup" \
			"${LOC}"/data/ciphire32.png \
			"Network" \
			"${LOC}"
	fi
}

pkg_postinst() {
	if [[ ${ROOT} == "/" ]] ; then
		use X && env -u DISPLAY "${LOC}"/ciphire-systemsetup xreinstall \
		      || env -u DISPLAY "${LOC}"/ciphire-systemsetup reinstall
	fi

	echo
	einfo "To setup Ciphire Mail for a user, please run as that user:"
	echo
	einfo "  ${LOC}/ciphire-setup"
	echo
	einfo "If you have previously had Ciphire Mail manually installed,"
	einfo "please uninstall it first (from dir you installed it):"
	echo
	einfo "  # ./ciphire-uninstall system"
	echo
	einfo "and then remerge ciphire-mail."
	echo
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

