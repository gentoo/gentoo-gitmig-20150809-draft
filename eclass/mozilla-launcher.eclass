# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/mozilla-launcher.eclass,v 1.3 2004/08/20 03:15:21 agriffis Exp $

ECLASS=mozilla-launcher
INHERITED="$INHERITED $ECLASS"

update_mozilla_launcher_symlinks() {
	local f browsers="mozilla firefox thunderbird sunbird"
	cd ${ROOT}/usr/bin

	# Remove launcher symlinks that no longer apply

	for f in ${browsers}; do
		if [[ -L ${f} && ! -f ${f} ]]; then
			einfo "Removing dangling ${f} launcher"
			rm -f ${f}
		fi
	done

	# Create symlinks
	#
	# - If there's a -bin symlink in /usr/bin, and no corresponding
	#   non-bin symlink, then create one.
	#
	# - Can't do this in src_install otherwise it overwrites the one
	#   for the non-bin package.
	#
	# - Link to the -bin symlink so it's easier to detect when to
	#   remove the symlink.

	for f in ${browsers}; do
		if [[ -L ${f}-bin && ! -e ${f} ]]; then
			einfo "Adding link from ${f}-bin to ${f}"
			ln -s ${f}-bin ${f}
		fi
	done
}
