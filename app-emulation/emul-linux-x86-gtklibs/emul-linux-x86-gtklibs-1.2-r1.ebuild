# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-gtklibs/emul-linux-x86-gtklibs-1.2-r1.ebuild,v 1.2 2005/03/30 23:21:15 cryos Exp $

DESCRIPTION="Gtk+ 1/2 for emulation of 32bit x86 on amd64"
SRC_URI="http://dev.gentoo.org/~lv/emul-linux-x86-gtklibs-${PV}.tar.bz2"
HOMEPAGE=""

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* amd64"
IUSE=""

S="${WORKDIR}"

DEPEND=">=app-emulation/emul-linux-x86-xlibs-1.2
	>=app-emulation/emul-linux-x86-baselibs-1.2.2"

pkg_preinst() {
	# Check for bad symlinks before installing
	if [ -L /usr/lib32/gtk-2.0 ]; then
		rm -f /usr/lib32/gtk-2.0
	fi
	if [ -L /usr/lib32/pango ]; then
		rm -f /usr/lib32/pango
	fi
}

src_install() {
	mkdir -p ${D}/etc/env.d
	echo "GDK_USE_XFT=1" > ${D}/etc/env.d/50emul-linux-x86-gtklibs
	cp -RPvf ${WORKDIR}/* ${D}/
}

pkg_postinst() {
	# Create the necessary symlinks for acroread 7 and firefox-bin
	if [ -d /usr/lib32/gtk-2.0 ] || [ -d /usr/lib32/pango ]; then
		if [ -L /usr/lib32 ]; then
			# This is a 2004.3 profile or lower
			einfo 2004.3 profile or lower - not creating symlinks
		else
			# 2005.0 or higher profile, directories present
			ewarn Unable to create necessary gtk-2.0 and pango symlinks in
			ewarn /usr/lib32/ - please check that these directories contain
			ewarn 32 bit libraries.
		fi
	else
		# Create symlinks
		cd /usr/lib32
		ln -s ../../emul/linux/x86/usr/lib32/gtk-2.0 gtk-2.0
		ln -s ../../emul/linux/x86/usr/lib32/pango pango
	fi
}

pkg_postrm() {
	# The symlinks should be removed if this package is removed
	if [ -L /usr/lib32/gtk-2.0 ] && [ ! -d /emul/linux/x86/usr/lib32/gtk-2.0 ] \
		&& [ -L /usr/lib32/pango ] && \
		[ ! -d /emul/linux/x86/usr/lib32/pango ]; then
		# The package has been removed, not upgraded
		rm -f /usr/lib32/gtk-2.0 /usr/lib32/pango
	fi
}
