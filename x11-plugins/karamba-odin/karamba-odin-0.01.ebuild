# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-odin/karamba-odin-0.01.ebuild,v 1.1 2003/05/04 06:26:38 prez Exp $

DESCRIPTION="Disk/floppy/CD status plugin for Karamba"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5820"
SRC_URI="http://www.kdelook.org/content/files/5820-karamba_odin.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="|| ( >=x11-misc/karamba-0.17 >=x11-misc/superkaramba-0.21 )"

src_unpack () {
	unpack ${A}
	mv karamba_odin ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/bin
	sed -e 's#~/karamba_odin/config#~/.karamba/odin_config#g' \
		-e 's#~/karamba_odin#/usr/share/karamba/bin#g' \
		menu >${D}/usr/share/karamba/bin/menu
	chmod 755 ${D}/usr/share/karamba/bin/menu
	sed -e 's#~/karamba_odin/config#~/.karamba/odin_config#g' \
		-e 's#~/karamba_odin#/usr/share/karamba/bin#g' \
		check_mountpoint >${D}/usr/share/karamba/bin/check_mountpoint
	chmod 755 ${D}/usr/share/karamba/bin/check_mountpoint
	sed -e 's#~/karamba_odin/config#~/.karamba/odin_config#g' \
		-e 's#~/karamba_odin#/usr/share/karamba/bin#g' \
		format_floppy >${D}/usr/share/karamba/bin/format_floppy
	chmod 755 ${D}/usr/share/karamba/bin/format_floppy
	sed -e 's#~/karamba_odin/config#~/.karamba/odin_config#g' \
		-e 's#~/karamba_odin#/usr/share/karamba/bin#g' \
		mount_umount >${D}/usr/share/karamba/bin/mount_umount
	chmod 755 ${D}/usr/share/karamba/bin/mount_umount
	sed -e 's#~/karamba_odin/config#~/.karamba/odin_config#g' \
		-e 's#~/karamba_odin#/usr/share/karamba/bin#g' \
		open >${D}/usr/share/karamba/bin/open
	chmod 755 ${D}/usr/share/karamba/bin/open

	dodir /usr/share/karamba/themes/odin
	sed -e 's#~/karamba_odin/config#~/.karamba/odin_config#g' \
		-e 's#~/karamba_odin#/usr/share/karamba/bin#g' \
		karamba_odin.theme >${D}/usr/share/karamba/themes/odin/odin.theme
	cp -r *.png ${D}/usr/share/karamba/themes/odin
	cp -r *.xcf ${D}/usr/share/karamba/themes/odin
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/odin

	dodoc README config
}
