# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/ltsp-core/ltsp-core-3.0.9-r1.ebuild,v 1.1 2003/04/16 12:31:30 frame Exp $


IUSE="gnome kde"

S=${WORKDIR}/${P}
DESCRIPTION="LTSP - Linux Terminal Server Project"
HOMEPAGE="http://www.ltsp.org/"
SRC_URI="mirror://sourceforge/ltsp/ltsp_core-3.0.9-i386.tgz
	mirror://sourceforge/ltsp/ltsp_kernel-3.0.5-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x_core-3.0.1-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x_fonts-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_3dlabs-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_8514-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_agx-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_fbdev-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_i128-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_mach32-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_mach64-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_mach8-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_mono-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_p9000-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_s3-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_s3v-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_svga-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_vga16-3.0.0-i386.tgz
	mirror://sourceforge/ltsp/ltsp_x336_w32-3.0.0-i386.tgz"

RDEPEND="gnome? ( >=gnome-base/gdm-2.4.0.0 )
	kde? ( >=kde-base/kdebase-3.0.2 )
	x11-base/xfree
	app-admin/tftp-hpa
	sys-apps/xinetd
	net-misc/dhcp
	net-fs/nfs-utils"

DEPEND="${RDEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

ltsp_strip_config() {
	local SOURCE="/"$1
	local TARGET=${D}/$SOURCE
	sed -e "/## LTS-begin ##/,/## LTS-end ##/d" < ${SOURCE} >> ${TARGET}
}

ltsp_copy_config() {
	local SOURCE="/"$1
	local TARGET=${D}/$SOURCE
	if test -f $SOURCE ; then
		cp $SOURCE $TARGET
	else
		echo "!!! No config file named $SOURCE"
		return 1
	fi
}

modify_exports()
{
	echo ">>> Modifying /etc/exports ..."

	# get the file
	ltsp_strip_config /etc/exports
	
	# insert new data
	cat >> ${D}/etc/exports <<EOF

## LTS-begin ##

#
# The lines between the 'LTS-begin' and the 'LTS-end' were added
# on: `date` by the ltsp installation script.
# For more information, visit the ltsp homepage
# at http://www.ltsp.org
#

/opt/ltsp/i386                  192.168.0.0/255.255.255.0(ro,no_root_squash)
/var/opt/ltsp/swapfiles         192.168.0.0/255.255.255.0(rw,no_root_squash)

#
# The following entries need to be uncommented if you want
# Local App support in ltsp
#
#/home                  192.168.0.0/255.255.255.0(rw,no_root_squash)

## LTS-end ##
EOF

}

modify_xdm_xdm_config()
{
	local file=/etc/X11/xdm/xdm-config

	if [ -f $file ] ; then
		echo ">>> Modifying $file ..."

		# get file
		ltsp_strip_config $file

		# make temp file
		mv ${D}$file ${D}$file.temp

		cat >> ${D}$file.temp <<EOF

## LTS-begin ##

#
# The lines between the 'LTS-begin' and the 'LTS-end' were added
# on: Mon Jan 21 21:40:50 CST 2002 by the ltsp installation script.
# For more information, visit the ltsp homepage
# at http://www.ltsp.org
#

DisplayManager.*.setup:     /etc/X11/xdm/Xsetup_workstation

## LTS-end ##
EOF

		# comment out display port line
		sed -e "s/^DisplayManager\.requestPort/\# DisplayManager.requestPort/" \
			< ${D}$file.temp >> ${D}$file

		# remove temp file
		rm -f ${D}$file.temp
	else
		echo "!!! $file not installed on system"
	fi
}

modify_xdm_Xservers()
{
	local file=/etc/X11/xdm/Xservers

	if [ -f $file ] ; then
		echo ">>> Modifying $file ..."

		# get file
		ltsp_strip_config $file

		# TODO: put this comment in a more sensical place!!
		cat >> ${D}$file <<EOF

## LTS-begin ##

# Comment the above line in order to disable xdm for the local machine!

## LTS-end ##
EOF
	else
		echo "!!! $file not installed on system"
	fi
}

modify_xdm_kdmrc() 
{
	local file=/usr/kde/3/share/config/kdm/kdmrc

	if [ -f $file ] ; then
		echo ">>> Modifying $file ..."

		# get file
		ltsp_strip_config $file

		# make temp file
		mv ${D}$file ${D}$file.temp
	
		# run custom perl script to modify the kdmrc
		${FILESDIR}/kdmrc.pl < ${D}/$file.temp >> ${D}/$file

		# remove temp file
		rm -f ${D}$file.temp
	else
		echo "!!! $file not installed on system"
	fi

}

modify_gdm_gdm_conf()
{
	local file=/etc/X11/gdm/gdm.conf

	if [ -f $file ] ; then
		echo ">>> Modifying $file ..."

		# get file
		ltsp_strip_config $file

		# make temp file
		mv ${D}$file ${D}$file.temp
	
		# run custom perl script to modify the gdm.conf
		${FILESDIR}/gdm.conf.pl < ${D}/$file.temp >> ${D}/$file

		# remove temp file
		rm -f ${D}$file.temp
	else
		echo "!!! $file not installed on system"
	fi
}

src_install() {
	local XSERVERS="3dlabs 8514 agx fbdev i128 mach32 mach64 mach8 mono p9000 \
					s3 s3v svga w32"

	echo ">>> Installing root LTSP directory ..."
	cd ${WORKDIR}/ltsp_core
	${FILESDIR}/install.sh i386 ${D}/opt/ltsp/
	dodoc INSTALL README ${FILESDIR}/INSTALL.Gentoo

	echo ">>> Installing the X core ..."
	cd ${WORKDIR}/ltsp_x_core
	${FILESDIR}/install.sh i386 ${D}/opt/ltsp/

	echo ">>> Installing the X fonts ..."
	cd ${WORKDIR}/ltsp_x_fonts
	${FILESDIR}/install.sh i386 ${D}/opt/ltsp/

	echo ">>> Installing the LTSP kernel ..."
	cd ${WORKDIR}/ltsp_kernel
	${FILESDIR}/install.sh i386 ${D}/opt/ltsp/
	dodir /tftpboot/lts
	dodir /tftpboot/pxe
	cp vmlinuz* ${D}/tftpboot/lts
	insinto /tftpboot/pxe
	doins ${FILESDIR}/eb-5.0.9-rtl8139.lzpxe
	doins ${FILESDIR}/eb-5.0.9-eepro100.lzpxe
	doins ${FILESDIR}/eb-5.0.9-3c905c-tpo.lzpxe

	echo ">>> Installing the X Servers ..."
	for d in $XSERVERS ; do
		cd ${WORKDIR}/ltsp_x336_$d
		${FILESDIR}/install.sh i386 ${D}/opt/ltsp/
	done

	# make config dirs
	dodir /usr/kde/3/share/config/kdm
	dodir /etc/X11/gdm
	
	ebegin "Copy the ltsp.conf file ..."
	insinto /etc
	doins ${FILESDIR}/ltsp.conf
	eend

	ebegin "Copying xdm files ..."
	insinto /etc/X11/xdm
	doins ${FILESDIR}/{Xsetup_workstation,ltsp.gif,Xaccess}
	eend

	ebegin "Copying dhcp files ..."
	insinto /etc/dhcp
	doins ${FILESDIR}/dhcpd.conf
	eend

	ebegin "Copying xinetd files ..."
	insinto /etc/xinetd.d
	doins ${FILESDIR}/tftp
	eend

	# modify config files
	modify_exports
	modify_xdm_xdm_config
	modify_xdm_Xservers
	if [ -n `use kde` ]; then
		modify_xdm_kdmrc
	fi
	
	# gdm requires a custom config
	if [ -n `use gnome` ]; then
		modify_gdm_gdm_conf
		ltsp_copy_config /etc/X11/gdm/Default

		if test -f ${D}/etc/X11/gdm/Default -o -L ${D}/etc/X11/gdm/Default; then
			mv ${D}/etc/X11/gdm/Default ${D}/etc/X11/gdm/\:0
		fi
		
		dosym /etc/X11/xdm/Xsetup_workstation /etc/X11/gdm/Default
	fi

	# ensure that these directories get copied even though they are empty
	for empty_dir in dev oldroot proc root tmp ; do
		keepdir /opt/ltsp/i386/${empty_dir}
	done
}

pkg_postinst() {
	einfo "*******************************************************************************************"
	einfo " | PLEASE LOOK AT THE MERGED CONFIG FILES AND UPDATE/OVERWRITE OLDER CONFS AS NEEDED! ***| "
	einfo "*******************************************************************************************"
	einfo " | YOU NEED TO EDIT YOUR UPDATED CONFIGURATION FILES TO COMPLETE THE LTSP INSTALLATION: *| "
	einfo " |---------------------------------------------------------------------------------------| "
	einfo " | FILE -------------------------| ACTION -----------------------------------------------| "
	einfo " |---------------------------------------------------------------------------------------| "
	einfo " | /etc/exports -----------------| Alter network address/netmask(nfs options) to match --| "
	einfo " |-------------------------------| your current network/nfs settings --------------------| "
	einfo " |---------------------------------------------------------------------------------------| "
	einfo " | /etc/dhcp/dhcpd.conf ---------| Alter it to match your network settings and other ----| "
	einfo " |-------------------------------| needs. Read comments inside dhcpd.conf for more... ---| "
	einfo " |---------------------------------------------------------------------------------------| "
	einfo " | /etc/conf.d/dhcp -------------| Alter IFACE setting if needed ------------------------| "
	einfo " |---------------------------------------------------------------------------------------| "
	einfo " | /opt/ltsp/i386/etc/lts.conf --| Alter LTSP config file to match your terminals -------| "
	einfo " |---------------------------------------------------------------------------------------| "
	einfo " | /etc/xinetd.d/tftp -----------| Change disable=yes to disable=no ---------------------| "
	einfo " |---------------------------------------------------------------------------------------| "
	einfo "*******************************************************************************************"
	einfo " | YOU NEED TO ACTIVATE THESE SERVICES TO RUN LTSP SERVER: ------------------------------| "
	einfo " |---------------------------------------------------------------------------------------| "
	einfo " | SERVICE ----------------------| ACTION -----------------------------------------------| "
	einfo " |---------------------------------------------------------------------------------------| "
	einfo " | DHCP -------------------------| /etc/init.d/dhcp start -------------------------------| "
	einfo " |-------------------------------| rc-update add dhcp default (for start at boot) -------| "
	einfo " |---------------------------------------------------------------------------------------| "
	einfo " | XDM --------------------------| /etc/init.d/xdm start --------------------------------| "
	einfo " |-------------------------------| rc-update add xdm default (for start at boot) --------| "
	einfo " |---------------------------------------------------------------------------------------| "
	einfo " | TFTP FROM XINETD -------------| /etc/init.d/xinetd start -----------------------------| "
	einfo " |-------------------------------| rc-update add xinetd default (for start at boot) -----| "
	einfo " |---------------------------------------------------------------------------------------| "
	einfo "*******************************************************************************************"
	einfo " | FOR MORE INFORMATION AND COMPLETE SET OF DOCUMENTATION GO TO WWW.LTSP.ORG  ***********| "
	einfo "*******************************************************************************************"	
}
