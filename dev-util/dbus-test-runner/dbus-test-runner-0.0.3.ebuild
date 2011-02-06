# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dbus-test-runner/dbus-test-runner-0.0.3.ebuild,v 1.1 2011/02/06 22:30:00 tampakrap Exp $

EAPI=3

inherit base

MY_MAJOR_VERSION="trunk"

DESCRIPTION="Run executables under a new DBus session for testing"
HOMEPAGE="https://launchpad.net/dbus-test-runner"
SRC_URI="http://launchpad.net/dbus-test-runner/${MY_MAJOR_VERSION}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="dev-libs/dbus-glib"
DEPEND="${RDEPEND}"
# Not packaged yet:
#	test? ( dev-util/bustle )

RESTRICT="test"
