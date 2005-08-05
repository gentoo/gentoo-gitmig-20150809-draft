# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mailer.eclass,v 1.15 2005/08/05 08:26:34 slarti Exp $

#
# Original Authors: Fernando J. Pereda <ferdy@gentoo.org>
#					Tom Martin <slarti@gentoo.org>
#
# Purpose: eclass to intarface with net-mail/mailer-config, used to manage
# multiple MTA's installed on a Gentoo system.
#
# Usage: call mailer_install_conf in src_install(), on the condition that
# "mailwrapper" is in USE. If mailer_install_conf has no arguments,
# ${FILESDIR}/mailer.conf will be installed to /etc/mail. If it is given a file
# as argument, this will be used. Also, please note that there is no need to
# IUSE="mailwrapper" or create RDEPENDS for mailwrapper as used to be the case.
# As you can see below, these are now set by this eclass. This rule also holds
# true for PROVIDE="virtual/mta".
#
##
# Functions available for ebuilds:
#
#  mailer_get_current()  - Returns the current profile (i.e. postfix-2.2.3)
#  mailer_install_conf() - Installs the profile file in ${1} or
#							${FILESDIR}/mailer.conf if ${1} is not specified.
#  mailer_set_profile()  - Sets the current profile to ${1} or to ${P} if ${1}
#							is not specified.
#  mailer_wipe_confs()   - Removes unused profiles (i.e. the profile exists but
#  							the package is no longer available)
##

IUSE="mailwrapper"
RDEPEND="mailwrapper? (
		|| (
			net-mail/mailer-config
			app-admin/eselect
		)
		>=net-mail/mailwrapper-0.2.1-r1
	)
	!mailwrapper? (
		!virtual/mta
	)"
PROVIDE="virtual/mta"

EXPORT_FUNCTIONS pkg_postinst pkg_postrm

# Gets current mailer profile
mailer_get_current() {
	mailer-config --get-current-profile
	return $?
}

# Installs a new mailer.conf given as an argument, else it installs
# ${FILESDIR}/mailer.conf
mailer_install_conf() {
	local newname

	if [[ ${PN} == "mailer-config" ]] ; then
		newname="default"
	else
		newname="${1:-${P}.mailer}"
	fi

	# If the newfile does not exist or the version in the system
	#  differs from the one in FILESDIR/ (update); install it
	if [[ ! -f /etc/mail/${newname} ]] || \
		! diff /etc/mail/${newname} "${FILESDIR}/mailer.conf" > /dev/null ; then
		insinto /etc/mail/
		newins "${FILESDIR}/mailer.conf" ${newname}
	fi
}

# Set current mailer profile
mailer_set_profile() {
	local newprofile=${1:-${P}}

	ebegin "Setting the current mailer profile to \"${newprofile}\""
		mailer-config --set-profile ${newprofile} >/dev/null || die
	eend $?
}

# Wipe unused configs
mailer_wipe_confs() {
	local x i

	ebegin "Wiping all unused mailer profiles"
		for x in /etc/mail/*.mailer ; do
			i=${x##*/}
			i=${i%.mailer}

			[[ ${i} == ${P} ]] && continue
			[[ ${i} == "default" ]] && continue
			has_version "~mail-mta/${i}" || rm ${x}
		done
	eend 0
}

mailer_pkg_postinst() {
	if use mailwrapper ; then
		if [[ $(mailer_get_current) == default ]] ; then
			mailer_set_profile
		else
			einfo " "
			einfo "Use either net-mail/mailer-config or app-admin/eselect to change"
			einfo "to this mailer profile:"
			einfo " "
			einfo "    mailer-config --set-profile ${P}"
			einfo "    eselect mailer set ${P}"
			einfo " "
		fi
	fi
}

mailer_pkg_postrm() {
	if use mailwrapper ; then
		mailer_wipe_confs

		# We are removing the current profile, switch back to default
		[[ $(mailer_get_current) == ${P} ]] && mailer_set_profile default
	fi
}
