# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/udev/udev-133.ebuild,v 1.1 2008/11/19 19:41:22 zzam Exp $

inherit eutils flag-o-matic multilib toolchain-funcs versionator autotools

DESCRIPTION="Linux dynamic and persistent device naming support (aka userspace devfs)"
HOMEPAGE="http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html"
SRC_URI="mirror://kernel/linux/utils/kernel/hotplug/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="selinux"

DEPEND="selinux? ( sys-libs/libselinux )"
RDEPEND="!sys-apps/coldplug
	!<sys-fs/device-mapper-1.02.19-r1"
RDEPEND="${DEPEND} ${RDEPEND}
	>=sys-apps/baselayout-1.12.5"
# We need the lib/rcscripts/addon support
PROVIDE="virtual/dev-manager"

pkg_setup() {
	udev_helper_dir="/$(get_libdir)/udev"

	# comparing kernel version without linux-info.eclass to not pull
	# virtual/linux-sources

	local KV=$(uname -r)
	local KV_MAJOR=$(get_major_version ${KV})
	local KV_MINOR=$(get_version_component_range 2 ${KV})
	local KV_MICRO=$(get_version_component_range 3 ${KV})

	local min_micro=15 min_micro_reliable=19

	local ok=0
	if [[ ${KV_MAJOR} == 2 && ${KV_MINOR} == 6 ]]
	then
		if [[ ${KV_MICRO} -ge ${min_micro_reliable} ]]; then
			ok=2
		elif [[ ${KV_MICRO} -ge ${min_micro} ]]; then
			ok=1
		fi
	fi

	if [[ ${ok} -lt 1 ]]
	then
		ewarn
		ewarn "${P} does not support Linux kernel before version 2.6.${min_micro}!"
	fi
	if [[ ${ok} -lt 2 ]]; then
		ewarn "If you want to use udev reliable you should update"
		ewarn "to at least kernel version 2.6.${min_micro_reliable}!"
		ewarn
		ebeep
	fi
}

# TODO: Can we keep the sources access /lib/udev and just
#   install the files to /lib64/udev ?
#   This makes eautoreconf superfluous
sed_helper_dir() {
	sed -e "s#/lib/udev#${udev_helper_dir}#" -i "$@"
}

src_unpack() {
	unpack ${A}

	cd "${S}"

	# patches go here...

	# Make sure there is no sudden changes to upstream rules file
	# (more for my own needs than anything else ...)
	MD5=$(md5sum < "${S}/rules/rules.d/50-udev-default.rules")
	MD5=${MD5/  -/}
	if [[ ${MD5} != da85d0a38ca61adc8714856a503bc8e8 ]]
	then
		echo
		eerror "50-udev-default.rules has been updated, please validate!"
		die "50-udev-default.rules has been updated, please validate!"
	fi

	sed_helper_dir \
		rules/rules.d/50-udev-default.rules \
		extras/rule_generator/write_*_rules \
		udev/udev-util.c \
		udev/udev-rules.c \
		udev/udevd.c \
		$(find -name "Makefile.*") || die "sed failed"

	# fix version of volume_id lib
	sed -e 's/-version-info/-version-number/' -i extras/volume_id/lib/Makefile.am

	eautoreconf
}

src_compile() {
	filter-flags -fprefetch-loop-arrays

	econf \
		--prefix=/usr \
		--sysconfdir=/etc \
		--exec-prefix= \
		--with-libdir-name=$(get_libdir) \
		--enable-logging \
		$(use_with selinux)

	# FIXME: logging causes messages about compat rules on boot

	emake || die "compiling udev failed"
}

src_install() {
	into /
	emake DESTDIR="${D}" install || die "make install failed"

	exeinto "${udev_helper_dir}"
	newexe "${FILESDIR}"/net-130-r1.sh net.sh	|| die "net.sh not installed properly"
	newexe "${FILESDIR}"/move_tmp_persistent_rules-112-r1.sh move_tmp_persistent_rules.sh \
		|| die "move_tmp_persistent_rules.sh not installed properly"
	newexe "${FILESDIR}"/write_root_link_rule-125 write_root_link_rule \
		|| die "write_root_link_rule not installed properly"
	newexe "${FILESDIR}"/shell-compat-118-r3.sh shell-compat.sh \
		|| die "shell-compat.sh not installed properly"

	keepdir "${udev_helper_dir}"/state
	keepdir "${udev_helper_dir}"/devices

	# create symlinks for these utilities to /sbin
	# where multipath-tools expect them to be (Bug #168588)
	dosym "..${udev_helper_dir}/vol_id" /sbin/vol_id
	dosym "..${udev_helper_dir}/scsi_id" /sbin/scsi_id

	# Add gentoo stuff to udev.conf
	echo "# If you need to change mount-options, do it in /etc/fstab" \
	>> "${D}"/etc/udev/udev.conf

	# let the dir exist at least
	keepdir /etc/udev/rules.d

	# Now installing rules
	cd "${S}"/rules
	insinto "${udev_helper_dir}"/rules.d/

	# Our rules files
	doins gentoo/??-*.rules
	doins packages/40-alsa.rules

	# Adding arch specific rules
	if [[ -f packages/40-${ARCH}.rules ]]
	then
		doins "packages/40-${ARCH}.rules"
	fi
	cd "${S}"

	# our udev hooks into the rc system
	insinto /$(get_libdir)/rcscripts/addons
	newins "${FILESDIR}"/udev-start-126.sh udev-start.sh
	newins "${FILESDIR}"/udev-stop-126.sh udev-stop.sh

	# The udev-post init-script
	newinitd "${FILESDIR}"/udev-postmount-130-r2.initd udev-postmount

	# init-script for >=openrc-0.3.1, Bug #240984
	newinitd "${FILESDIR}/udev.initd" udev

	insinto /etc/modprobe.d
	newins "${FILESDIR}"/blacklist-110 blacklist
	doins "${FILESDIR}"/pnp-aliases

	# convert /lib/udev to real used dir
	sed_helper_dir \
		"${D}/$(get_libdir)"/rcscripts/addons/*.sh \
		"${D}"/etc/init.d/udev* \
		"${D}"/etc/modprobe.d/*

	# documentation
	dodoc ChangeLog README TODO || die "failed installing docs"

	cd docs/writing_udev_rules
	mv index.html writing_udev_rules.html
	dohtml *.html

	cd "${S}"

	newdoc extras/volume_id/README README_volume_id

	echo "CONFIG_PROTECT_MASK=\"/etc/udev/rules.d\"" > 20udev
	doenvd 20udev
}

pkg_preinst() {
	if [[ -d ${ROOT}/lib/udev-state ]]
	then
		mv -f "${ROOT}"/lib/udev-state/* "${D}"/lib/udev/state/
		rm -r "${ROOT}"/lib/udev-state
	fi

	if [[ -f ${ROOT}/etc/udev/udev.config &&
	     ! -f ${ROOT}/etc/udev/udev.rules ]]
	then
		mv -f "${ROOT}"/etc/udev/udev.config "${ROOT}"/etc/udev/udev.rules
	fi

	# delete the old udev.hotplug symlink if it is present
	if [[ -h ${ROOT}/etc/hotplug.d/default/udev.hotplug ]]
	then
		rm -f "${ROOT}"/etc/hotplug.d/default/udev.hotplug
	fi

	# delete the old wait_for_sysfs.hotplug symlink if it is present
	if [[ -h ${ROOT}/etc/hotplug.d/default/05-wait_for_sysfs.hotplug ]]
	then
		rm -f "${ROOT}"/etc/hotplug.d/default/05-wait_for_sysfs.hotplug
	fi

	# delete the old wait_for_sysfs.hotplug symlink if it is present
	if [[ -h ${ROOT}/etc/hotplug.d/default/10-udev.hotplug ]]
	then
		rm -f "${ROOT}"/etc/hotplug.d/default/10-udev.hotplug
	fi

	# is there a stale coldplug initscript? (CONFIG_PROTECT leaves it behind)
	coldplug_stale=""
	if [[ -f ${ROOT}/etc/init.d/coldplug ]]
	then
		coldplug_stale="1"
	fi

	has_version "=${CATEGORY}/${PN}-103-r3"
	previous_equal_to_103_r3=$?

	has_version "<${CATEGORY}/${PN}-104-r5"
	previous_less_than_104_r5=$?

	has_version "<${CATEGORY}/${PN}-106-r5"
	previous_less_than_106_r5=$?

	has_version "<${CATEGORY}/${PN}-113"
	previous_less_than_113=$?

	has_version "<${CATEGORY}/${PN}-133"
	previous_less_than_133=$?
}

# enable udev init-script, else system will no longer boot
# after update to openrc-0.3.1, Bug #240984
enable_udev_init_script() {
	local result=msg

	if [[ -e "${ROOT}"/etc/runlevels/sysinit/udev ]]
	then
		# already enabled
		result=enabled
	elif has_version ">=sys-apps/openrc-0.3.1"
	then
		# openrc without addon calls - no idea what to do, so just print msg
		result=msg
	else
		local rc_devices=
		if has_version "sys-apps/openrc"; then
			# openrc with udev addon calls
			rc_devices=$(source ${ROOT}/etc/rc.conf; echo $rc_devices)
			[[ -z "$rc_devices" ]] && rc_devices=auto
		else
			# old baselayout
			rc_devices=$(source ${ROOT}/etc/conf.d/rc; echo $RC_DEVICES)
		fi

		case ${rc_devices} in
			auto|udev)	result=add ;;
		esac
	fi

	case "$result" in
	enabled)
		einfo "udev init-script is already enabled, nothing to do."
		;;
	add)
		# enable udev init-script for new openrc
		elog "Auto adding udev init script to the sysinit runlevel"
		mkdir -p "${ROOT}"/etc/runlevels/sysinit
		ln -sf /etc/init.d/udev "${ROOT}"/etc/runlevels/sysinit
		;;
	msg)
		ewarn
		ewarn "You need to add the udev init script to the runlevel sysinit,"
		ewarn "else your system will not be able to boot"
		ewarn "after updating to >=openrc-0.3.1"
		ewarn "Run this to enable udev for >=openrc-0.3.1:"
		ewarn "\trc-update add udev sysinit"
		ewarn
		;;
	esac
}

fix_old_persistent_net_rules() {
	local rules=${ROOT}/etc/udev/rules.d/70-persistent-net.rules
	[[ -f ${rules} ]] || return

	ebegin "Fixing persistent-net rules file"

	# Change ATTRS to ATTR matches, Bug #246927
	sed -i -e 's/ATTRS{/ATTR{/g' "${rules}"

	# Add KERNEL matches if missing, Bug #246849
	sed -ri \
		-e '/KERNEL/ ! { s/NAME="(eth|wlan|ath)([0-9]+)"/KERNEL=="\1*", NAME="\1\2"/}' \
		"${rules}"

	eend 0 ""
}

# See Bug #129204 for a discussion about restarting udevd
restart_udevd() {
	# need to merge to our system
	[[ ${ROOT} = / ]] || return

	# check if root of init-process is identical to ours (not in chroot)
	[[ -r /proc/1/root && /proc/1/root/ -ef /proc/self/root/ ]] || return

	# abort if there is no udevd running
	[[ -n $(pidof udevd) ]] || return

	# abort if no /dev/.udev exists
	[[ -e /dev/.udev ]] || return

	elog
	elog "restarting udevd now."
	elog

	killall -15 udevd &>/dev/null
	sleep 1
	killall -9 udevd &>/dev/null

	/sbin/udevd --daemon
}

pkg_postinst() {
	# people want reminders, I'll give them reminders.  Odds are they will
	# just ignore them anyway...

	if [[ ${coldplug_stale} == 1 ]]
	then
		ewarn "A stale coldplug init script found. You should run:"
		ewarn
		ewarn "      rc-update del coldplug"
		ewarn "      rm -f /etc/init.d/coldplug"
		ewarn
		ewarn "udev now provides its own coldplug functionality."
	fi

	# delete 40-scsi-hotplug.rules - all integrated in 50-udev.rules
	if [[ $previous_equal_to_103_r3 = 0 ]] &&
		[[ -e ${ROOT}/etc/udev/rules.d/40-scsi-hotplug.rules ]]
	then
		ewarn "Deleting stray 40-scsi-hotplug.rules"
		ewarn "installed by sys-fs/udev-103-r3"
		rm -f "${ROOT}"/etc/udev/rules.d/40-scsi-hotplug.rules
	fi

	# Removing some device-nodes we thought we need some time ago
	if [[ -d ${ROOT}/lib/udev/devices ]]
	then
		rm -f "${ROOT}"/lib/udev/devices/{null,zero,console,urandom}
	fi

	# Removing some old file
	if [[ $previous_less_than_104_r5 = 0 ]]
	then
		rm -f "${ROOT}"/etc/dev.d/net/hotplug.dev
		rmdir --ignore-fail-on-non-empty "${ROOT}"/etc/dev.d/net 2>/dev/null
	fi

	if [[ $previous_less_than_106_r5 = 0 ]] &&
		[[ -e ${ROOT}/etc/udev/rules.d/95-net.rules ]]
	then
		rm -f "${ROOT}"/etc/udev/rules.d/95-net.rules
	fi

	# Try to remove /etc/dev.d as that is obsolete
	if [[ -d ${ROOT}/etc/dev.d ]]
	then
		rmdir --ignore-fail-on-non-empty "${ROOT}"/etc/dev.d/default "${ROOT}"/etc/dev.d 2>/dev/null
		if [[ -d ${ROOT}/etc/dev.d ]]
		then
			ewarn "You still have the directory /etc/dev.d on your system."
			ewarn "This is no longer used by udev and can be removed."
		fi
	fi

	# 64-device-mapper.rules now gets installed by sys-fs/device-mapper
	# remove it if user don't has sys-fs/device-mapper installed
	if [[ $previous_less_than_113 = 0 ]] &&
		[[ -f ${ROOT}/etc/udev/rules.d/64-device-mapper.rules ]] &&
		! has_version sys-fs/device-mapper
	then
			rm -f "${ROOT}"/etc/udev/rules.d/64-device-mapper.rules
			einfo "Removed unneeded file 64-device-mapper.rules"
	fi

	# requested in Bug #225033:
	elog
	elog "persistent-net does assigning fixed names to network devices."
	elog "If you have problems with persistent-net rules,"
	elog "just delete the rules file"
	elog "\trm ${ROOT}etc/udev/rules.d/70-persistent-net.rules"
	elog "and then trigger udev by either running"
	elog "\tudevadm trigger --subsystem-match=net"
	elog "or by rebooting."
	elog
	elog "This may number your devices in a different way than it is now."

	fix_old_persistent_net_rules

	restart_udevd

	ewarn "If you build an initramfs including udev, then please"
	ewarn "make sure that the /sbin/udevadm binary gets included,"
	ewarn "and your scripts changed to use it,as it replaces the"
	ewarn "old helper apps udevinfo, udevtrigger, ..."

	ewarn
	ewarn "mount options for directory /dev are no longer"
	ewarn "set in /etc/udev/udev.conf, but in /etc/fstab"
	ewarn "as for other directories."

	if [[ $previous_less_than_133 = 0 ]]
	then
		enable_udev_init_script
	fi

	elog
	elog "For more information on udev on Gentoo, writing udev rules, and"
	elog "         fixing known issues visit:"
	elog "         http://www.gentoo.org/doc/en/udev-guide.xml"
}
