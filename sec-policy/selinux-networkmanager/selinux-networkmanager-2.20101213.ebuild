# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-networkmanager/selinux-networkmanager-2.20101213.ebuild,v 1.2 2011/06/02 12:40:04 blueness Exp $

IUSE=""

MODS="networkmanager"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for general applications"

KEYWORDS="amd64 x86"

MODDEPEND=">=sec-policy/selinux-base-policy-2.20101213-r1"

# Patch "fix-networkmanager.patch" contains:
# - Support for wpa_cli. Gentoo's init scripts use wpa_cli to run the init
#   scripts when wpa_supplicant has associated.
# - Support running wpa_cli from commandline (requires
#   selinux-base-policy-2.20101213-r1) due to patch to sysadm_t domain
POLICY_PATCH="${FILESDIR}/fix-networkmanager.patch"
