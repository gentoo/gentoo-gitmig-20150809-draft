# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/lenovo-sl-laptop/lenovo-sl-laptop-9999.ebuild,v 1.1 2009/05/13 23:19:02 yngwin Exp $

inherit eutils git linux-mod

DESCRIPTION="Linux kernel support for the Lenovo SL series ThinkPads"
HOMEPAGE="http://github.com/tetromino/lenovo-sl-laptop"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

EGIT_REPO_URI="git://github.com/tetromino/lenovo-sl-laptop.git"
EGIT_BRANCH="master"

CONFIG_CHECK="HWMON BACKLIGHT_CLASS_DEVICE"
MODULE_NAMES="${PN}(acpi)"
BUILD_TARGETS="module"

src_install() {
		linux-mod_src_install
		dodoc README
}
