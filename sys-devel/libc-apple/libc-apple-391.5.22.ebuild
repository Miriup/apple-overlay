# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit toolchain-funcs

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="http://opensource.apple.com/tarballs/Libc/Libc-${PV}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-devel/CoreOSMakefiles virtual/pmake"
RDEPEND="${DEPEND}"

S=${WORKDIR}/Libc-${PV}

src_compile() {
	pmake CFLAGS="${CFLAGS}" CC="$(tc-getCC)" CHOST="${CHOST}"
}
