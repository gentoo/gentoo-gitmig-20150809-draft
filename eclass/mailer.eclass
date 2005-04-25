# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mailer.eclass,v 1.2 2005/04/25 16:15:21 ferdy Exp $

#
# Original Author: Fernando J. Pereda <ferdy@gentoo.org>
# Purpose: eclass to intarface with net-mail/mailer-config, used to manage
# multiple MTA's installed on a Gentoo system. 
#

ECLASS="mailer"
INHERITED="$INHERITED $ECLASS"
IUSE="${IUSE} mailwrapper"
RDEPEND="${RDEPEND}
	mailwrapper? ( net-mail/mailer-config
					>=net-mail/mailwrapper-0.2.1-r1 )
	!mailwrapper? ( !virtual/mta )"
PROVIDE="virtual/mta"

EXPORT_FUNCTIONS pkg_postinst pkg_postrm

# Gets current mailer profile
mailer_get_current() {
	echo $(mailer-config --get-current-profile)
	return $?
}

# Installs a new mailer.conf from FILESDIR
mailer_install_conf() {
	local newname

	if [[ ${PN} == "mailer-config" ]] ; then
		newname="default"
	else
		newname=${P}
	fi

	# If the newfile does not exist or the version in the system
	#  differs from the one in FILESDIR/ (update); install it
	if [[ ! -f /etc/mail/${newname}.mailer ]] || \
		! diff /etc/mail/${newname}.mailer "${FILESDIR}/mailer.conf" > /dev/null ; then
		insinto /etc/mail/
		newins "${FILESDIR}/mailer.conf" ${newname}.mailer
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

	ebegin "Wiping all non-used mailer profiles"
		for x in /etc/mail/*.mailer ; do
			i=${x##*/}
			i=${i%.mailer}

			[[ ${i} == ${P} ]] && continue
			[[ ${i} == "default" ]] && continue

			if ! has_version '=mail-mta/${i}*' ; then
				rm ${x}
			fi
		done
	eend 0
}

mailer_pkg_postinst() {
	use mailwrapper && mailer_set_profile
}

mailer_pkg_postrm() {
	if use mailwrapper ; then
		mailer_wipe_confs

		# We are removing the current profile, switch back to default
		[[ $(mailer_get_current) == ${P} ]] &&	mailer_set_profile default
	fi
}
