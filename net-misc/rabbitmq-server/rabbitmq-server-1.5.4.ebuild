# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rabbitmq-server/rabbitmq-server-1.5.4.ebuild,v 1.2 2009/04/19 16:39:22 mr_bones_ Exp $

inherit eutils

DESCRIPTION="RabbitMQ is a high-performance AMQP-compliant message broker written in Erlang."
HOMEPAGE="http://www.rabbitmq.com/"
SRC_URI="http://www.rabbitmq.com/releases/rabbitmq-server/v${PV}/rabbitmq-server-generic-unix-${PV}.tar.gz"
LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Q: is RDEPEND-only sufficient for a binary package, since we don't compile?
DEPEND="dev-lang/erlang"
RDEPEND="${DEPEND}"

# grr: the packaged directory contains an underscore
MODNAME="rabbitmq_server-${PV}"
S="${WORKDIR}/${MODNAME}"

src_install() {
	# erlang module
	local targetdir="/usr/$(get_libdir)/erlang/lib/${MODNAME}"
	dodir "${targetdir}"
	cp -dpR ebin include "${D}/${targetdir}"

	# scripts
	dosbin sbin/*

	# docs
	dodoc INSTALL LICENSE-MPL-RabbitMQ

	newinitd "${FILESDIR}/rabbitmq-server.init" rabbitmq-server

	# TODO:
	# config to set env vars as per INSTALL?
	# set LOGDIR to /var/log/rabbitmq.log
	# run as different user?
}
