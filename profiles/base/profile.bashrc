# Copyright 2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/profiles/base/profile.bashrc,v 1.1 2006/06/29 22:07:02 solar Exp $

for conf in ${PN} ${PN}-${PV} ${PN}-${PV}-${PR}; do
	[[ -r ${PORTAGE_CONFIGROOT}/etc/portage/env/${CATEGORY}/${conf} ]] \
		&& . ${PORTAGE_CONFIGROOT}/etc/portage/env/${CATEGORY}/${conf}
done
