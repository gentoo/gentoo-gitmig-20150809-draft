# Copyright 2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/profiles/hardened/profile.bashrc,v 1.1 2005/04/05 22:13:35 solar Exp $

case "${EBUILD_PHASE}" in
	install)
		# Our syslog-ng maintainer is not fond of giving users a decent default syslog-ng.conf
		if [[ $PN = "syslog-ng" ]]; then
		newins() {
			if [ -z "${T}" ] || [ -z "${2}" ] ; then
				echo "Error: Nothing defined to do."
				return 1
			fi
			rm -rf "${T}/${2}"
			cp "${1}" "${T}/${2}"

			if [[ $1 = "${FILESDIR}/syslog-ng.conf.gentoo" ]] \
				&& [ -e "${FILESDIR}/syslog-ng.conf.gentoo.hardened" ]; then

				cp "${FILESDIR}/syslog-ng.conf.gentoo.hardened" "${T}/${2}"
			fi
			doins "${T}/${2}"
		}
		fi
	;;
	*) ;;
esac
